//
//  ViewController.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
#import "DetailsViewController.h"
#import "HistoricoViewController.h"
#import "iTunesManager.h"
#import "Entidades/Filme.h"
#import "Entidades/Musica.h"
#import "Entidades/Podcast.h"
#import "Entidades/eBook.h"

@interface TableViewController () {
    NSArray *midias, *filmes, *musicas, *podcasts, *ebooks;
    NSMutableArray *termos;
}

@end

@implementation TableViewController

#pragma mark - Inicialização

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"celulaPadrao"];
    self.searchBar.delegate = self;
#warning Necessario para que a table view tenha um espaco em relacao ao topo, pois caso contrario o texto ficara atras da barra superior
//    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.bounds.size.width, 0.f)];
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:11], NSFontAttributeName, nil];
    [self.segmentControl setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    [self setTitle:NSLocalizedString(@"Buscador do iTunes", nil)];
    [self.searchBar setPlaceholder:NSLocalizedString(@"Buscar", nil)];
    [self carregarHistorico];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Métodos do UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self.segmentControl selectedSegmentIndex] == 0)
        return 4;
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //Filmes
    if (([self.segmentControl selectedSegmentIndex] == 0 && section == 0) ||
        [self.segmentControl selectedSegmentIndex] == 1)
        return filmes.count;
    //Músicas
    else if (([self.segmentControl selectedSegmentIndex] == 0 && section == 1) ||
               [self.segmentControl selectedSegmentIndex] == 2)
        return musicas.count;
    //Podcasts
    else if (([self.segmentControl selectedSegmentIndex] == 0 && section == 2) ||
               [self.segmentControl selectedSegmentIndex] == 3)
        return podcasts.count;
    //eBooks
    else if (([self.segmentControl selectedSegmentIndex] == 0 && section == 3) ||
               [self.segmentControl selectedSegmentIndex] == 4)
        return ebooks.count;
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *celula = [self.tableView dequeueReusableCellWithIdentifier:@"celulaPadrao"];
    //Filmes
    if (([self.segmentControl selectedSegmentIndex] == 0 && indexPath.section == 0) ||
        [self.segmentControl selectedSegmentIndex] == 1) {
        Filme *filme = [filmes objectAtIndex:indexPath.row];
        [celula.nome setText:filme.nome];
        [celula.tipo setText:@"Filme"];
        [celula.genero setText:filme.genero];
        [celula.artista setText:filme.artista];
        [celula.preco setText:[NSString stringWithFormat:@"$%@", filme.preco]];
        [celula.imagem setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", filme.imagem]]]]];
        //Músicas
    } else if (([self.segmentControl selectedSegmentIndex] == 0 && indexPath.section == 1) ||
               [self.segmentControl selectedSegmentIndex] == 2) {
        Musica *musica = [musicas objectAtIndex:indexPath.row];
        [celula.nome setText:musica.nome];
        [celula.tipo setText:@"Música"];
        [celula.genero setText:musica.genero];
        [celula.artista setText:musica.artista];
        [celula.preco setText:[NSString stringWithFormat:@"$%@", musica.preco]];
        [celula.imagem setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", musica.imagem]]]]];
        //Podcasts
    } else if (([self.segmentControl selectedSegmentIndex] == 0 && indexPath.section == 2) ||
               [self.segmentControl selectedSegmentIndex] == 3) {
        Podcast *podcast = [podcasts objectAtIndex:indexPath.row];
        [celula.nome setText:podcast.nome];
        [celula.tipo setText:@"Podcast"];
        [celula.genero setText:[podcast.generos objectAtIndex:0]];
        [celula.artista setText:podcast.artista];
        [celula.preco setText:[NSString stringWithFormat:@"$%@", podcast.preco]];
        [celula.imagem setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", podcast.imagem]]]]];
        //eBooks
    } else if (([self.segmentControl selectedSegmentIndex] == 0 && indexPath.section == 3) ||
               [self.segmentControl selectedSegmentIndex] == 4) {
        eBook *ebook = [ebooks objectAtIndex:indexPath.row];
        [celula.nome setText:ebook.nome];
        [celula.tipo setText:@"eBook"];
        [celula.genero setText:[ebook.generos objectAtIndex:0]];
        [celula.artista setText:ebook.artista];
        [celula.preco setText:[NSString stringWithFormat:@"$%@", ebook.preco]];
        [celula.imagem setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", ebook.imagem]]]]];
    }
    return celula;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    if (midias.count != 0) {
        [headerView setFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 4, tableView.frame.size.width, 18)];
        [headerLabel setFont:[UIFont boldSystemFontOfSize:15]];
        [headerView setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]];
        UIImage *imagem;
        if (([self.segmentControl selectedSegmentIndex] == 0 && section == 0 && filmes.count != 0) ||
            [self.segmentControl selectedSegmentIndex] == 1) {
            [headerLabel setText:@"Filmes"];
            imagem = [UIImage imageNamed:@"filme.png"];
        } else if (([self.segmentControl selectedSegmentIndex] == 0 && section == 1 && musicas.count != 0) ||
                   [self.segmentControl selectedSegmentIndex] == 2) {
            [headerLabel setText:@"Músicas"];
            imagem = [UIImage imageNamed:@"musica.png"];
        } else if (([self.segmentControl selectedSegmentIndex] == 0 && section == 2 && podcasts.count != 0) ||
                   [self.segmentControl selectedSegmentIndex] == 3) {
            [headerLabel setText:@"Podcasts"];
            imagem = [UIImage imageNamed:@"podcast.png"];
        } else if (([self.segmentControl selectedSegmentIndex] == 0 && section == 3 && ebooks.count != 0) ||
                   [self.segmentControl selectedSegmentIndex] == 4) {
            [headerLabel setText:@"eBooks"];
            imagem = [UIImage imageNamed:@"ebook.png"];
        }
        UIImageView *headerImage = [[UIImageView alloc] initWithImage:imagem];
        headerImage.frame = CGRectMake(0, 2, 20, 20);
        [headerView addSubview:headerLabel];
        [headerView addSubview:headerImage];
    }
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailsViewController *detailsViewController = [[DetailsViewController alloc] init];
    iTunesManager *itunes = [iTunesManager sharedInstance];
    if ([self.segmentControl selectedSegmentIndex] == 0)
        itunes.midia = [[midias objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    else
        itunes.midia = [[midias objectAtIndex:[self.segmentControl selectedSegmentIndex]-1] objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailsViewController animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}


#pragma mark - Interface

- (IBAction)segmentChanged:(id)sender {
    [self.tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    iTunesManager *itunes = [iTunesManager sharedInstance];
    NSString *termo = [NSString stringWithFormat:@"%@", searchBar.text];
    termo = [termo stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([self validarTermo:termo]) {
        [termos removeObject:termo];
        [termos addObject:termo];
        [self salvarHistorico];
        midias = [itunes buscarMidias:[termo stringByReplacingOccurrencesOfString:@" " withString:@"+"]];
        filmes = [midias objectAtIndex:0];
        musicas = [midias objectAtIndex:1];
        podcasts = [midias objectAtIndex:2];
        ebooks = [midias objectAtIndex:3];
        [self.searchBar resignFirstResponder];
        [self.tableView reloadData];
    } else
        NSLog(@"Termo de pesquisa inválido.");
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
}

-(void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar {
    HistoricoViewController *historicoViewController = [[HistoricoViewController alloc] init];
    iTunesManager *itunes = [iTunesManager sharedInstance];
    itunes.termos = termos;
    [self.navigationController pushViewController:historicoViewController animated:YES];
}


#pragma mark - Dados

- (BOOL)validarTermo:(NSString *)termo {
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[a-z0-9]{3,}" options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *matches = [regex matchesInString:termo options:0 range:NSMakeRange(0, termo.length)];
    if (matches.count > 0)
        return YES;
    return NO;
}

- (void)salvarHistorico {
    NSUserDefaults *historico = [NSUserDefaults standardUserDefaults];
    if (termos.count)
        [historico setValue:termos forKey:@"historicoBusca"];
}

- (void)carregarHistorico {
    NSUserDefaults *historico = [NSUserDefaults standardUserDefaults];
    termos = [historico objectForKey:@"historicoBusca"];
    if (!termos)
        termos = [[NSMutableArray alloc] init];
}

@end
