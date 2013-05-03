//
//  MainViewController.m
//  KonfAid
//
//  Created by Ricki Gregersen on 5/3/13.
//  Copyright (c) 2013 Ricki Gregersen. All rights reserved.
//

#import "MainViewController.h"
#import "RGTesseractModel.h"

@interface MainViewController ()

@property RGTesseractModel *model;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    _model = [RGTesseractModel new];
    UIImage *image = [UIImage imageNamed:@"IMG_0002.png"];
    [_model OCRImage:image withHandler:^(NSString *result) {
        
        NSLog(@"I see : %@", result);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
