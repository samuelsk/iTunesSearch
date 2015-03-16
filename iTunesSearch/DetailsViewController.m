//
//  DetailViewController.m
//  iTunesSearch
//
//  Created by Samuel Shin Kim on 13/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "DetailsViewController.h"
#import "iTunesManager.h"
#import "Entidades/Filme.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    iTunesManager *itunes = [iTunesManager sharedInstance];
    NSString *title = itunes.midia.nome;
    [self.nome setText:title];
    [self.artista setText:itunes.midia.artista];
    [self.genero setText:itunes.midia.genero];
    [self.pais setText:itunes.midia.pais];
    [self.preco setText:[NSString stringWithFormat:@"$%@", itunes.midia.preco]];
    [self.dataLanc setText:[[itunes.midia.dataLanc description] substringToIndex:10]];
    [self.imagem setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", itunes.midia.imagemHD]]]]];
    //@implementar alguma maneira de mostrar as informações adicionais de cada subclasse.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (IBAction)abrirLoja:(id)sender {
    iTunesManager *itunes = [iTunesManager sharedInstance];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", itunes.midia.link]]];
}
@end
