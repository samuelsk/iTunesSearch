//
//  DetailViewController.h
//  iTunesSearch
//
//  Created by Samuel Shin Kim on 13/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *nome;
@property (weak, nonatomic) IBOutlet UILabel *artista;
@property (weak, nonatomic) IBOutlet UILabel *genero;
@property (weak, nonatomic) IBOutlet UILabel *pais;
@property (weak, nonatomic) IBOutlet UILabel *dataLanc;
@property (weak, nonatomic) IBOutlet UILabel *preco;
@property (weak, nonatomic) IBOutlet UIImageView *imagem;

- (IBAction)abrirLoja:(id)sender;

@end
