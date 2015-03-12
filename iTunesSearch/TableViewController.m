//
//  ViewController.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
#import "iTunesManager.h"
#import "Entidades/Filme.h"
#import "Entidades/Musica.h"
#import "Entidades/Podcast.h"
#import "Entidades/eBook.h"

@interface TableViewController () {
    NSArray *filmes;
    NSArray *musicas;
    NSArray *podcasts;
    NSArray *ebooks;
}

@end

@implementation TableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"celulaPadrao"];
    self.textField.delegate = self;
#warning Necessario para que a table view tenha um espaco em relacao ao topo, pois caso contrario o texto ficara atras da barra superior
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.bounds.size.width, 0.f)];
    self.textField.placeholder = @"Buscar";
    [self.textField setKeyboardType:UIKeyboardTypeWebSearch];
    [self.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    //NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:11], NSFontAttributeName, nil];
    //[self.segmentControl setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Metodos do UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self.segmentControl selectedSegmentIndex] == 0)
        return 4;
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch ([self.segmentControl selectedSegmentIndex]) {
        //Todos
        case 0:
            if (section == 0)
                return [filmes count];
            if (section == 1)
                return [musicas count];
            if (section == 2)
                return[podcasts count];
            if (section == 3)
                return [ebooks count];
            break;
        //Filmes
        case 1:
            return [filmes count];
            break;
        //Músicas
        case 2:
            return [musicas count];
            break;
        //Podcasts
        case 3:
            return [podcasts count];
            break;
        //eBooks
        case 4:
            return [ebooks count];
            break;
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch ([self.segmentControl selectedSegmentIndex]) {
        case 0:
            if (section == 0)
                return @"Filmes";
            if (section == 1)
                return @"Músicas";
            if (section == 2)
                return @"Podcasts";
            if (section == 3)
                return @"eBooks";
            break;
        case 1:
            return @"Filmes";
            break;
        case 2:
            return @"Músicas";
            break;
        case 3:
            return @"Podcasts";
            break;
        case 4:
            return @"eBooks";
            break;
    }
    return @"";
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *celula = [self.tableView dequeueReusableCellWithIdentifier:@"celulaPadrao"];
    if (indexPath.section == 0) {
        if ([self.segmentControl selectedSegmentIndex] <= 1) {
            Filme *filme = [filmes objectAtIndex:indexPath.row];
            [celula.nome setText:filme.nome];
            [celula.tipo setText:@"Filme"];
            [celula.genero setText:filme.genero];
            [celula.artista setText:filme.artista];
        } else if ([self.segmentControl selectedSegmentIndex] == 2) {
            Musica *musica = [musicas objectAtIndex:indexPath.row];
            [celula.nome setText:musica.nome];
            [celula.tipo setText:@"Música"];
        } else if ([self.segmentControl selectedSegmentIndex] == 3) {
            Podcast *podcast = [podcasts objectAtIndex:indexPath.row];
            [celula.nome setText:podcast.nome];
            [celula.tipo setText:@"Podcast"];
        } else if ([self.segmentControl selectedSegmentIndex] == 4) {
            eBook *ebook = [ebooks objectAtIndex:indexPath.row];
            [celula.nome setText:ebook.nome];
            [celula.tipo setText:@"eBook"];
        }
    }
    return celula;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (IBAction)segmentChanged:(id)sender {
    [self.tableView reloadData];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.textField) {
        iTunesManager *itunes = [iTunesManager sharedInstance];
        NSString *termo = [NSString stringWithFormat:@"%@", self.textField.text];
        NSArray *midias = [[NSMutableArray alloc] init];
        midias = [itunes buscarMidias:[termo stringByReplacingOccurrencesOfString:@" " withString:@"+"]];
        filmes = [midias objectAtIndex:0];
        musicas = [midias objectAtIndex:1];
        podcasts = [midias objectAtIndex:2];
        ebooks = [midias objectAtIndex:3];
        [self.tableView reloadData];
        [self.textField resignFirstResponder];
        return NO;
    }
    return YES;
}


@end
