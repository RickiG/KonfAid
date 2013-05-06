//
//  MainViewController.m
//  KonfAid
//
//  Created by Ricki Gregersen on 5/3/13.
//  Copyright (c) 2013 Ricki Gregersen. All rights reserved.
//

#import "MainViewController.h"
#import "RGTesseractModel.h"
#import "RGCredentialsModel.h"
#import "RGCredentialsEntity.h"
#import "RGCell.h"

@interface MainViewController ()

@property RGTesseractModel *tesseractModel;
@property RGCredentialsModel *credentialsModel;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [_button addTarget:self action:@selector(buttonHandler:) forControlEvents:UIControlEventTouchUpInside];
    
    _tesseractModel = [RGTesseractModel new];    
}

- (void) buttonHandler:(id) sender
{
//    _image.image = [UIImage imageNamed:@"test_chris.png"];
    _image.image = [UIImage imageNamed:@"photo.png"];    
    _button.hidden = YES;
    
    [self performSelector:@selector(ocr) withObject:nil afterDelay:3.0f];
    _tableView.alpha = 0.3f;
    _image.alpha = 0.3f;
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.tag = 1000;
    [indicator startAnimating];
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
}

- (void) ocr
{
    [[self.view viewWithTag:1000] removeFromSuperview];
    
    _tableView.alpha = 1.0f;
    _image.alpha = 1.0f;
    
    [_tesseractModel OCRImage:_image.image withHandler:^(NSString *result) {
        
        NSLog(@"I see : %@", result);
        _credentialsModel = [[RGCredentialsModel alloc] initWithText:result];
        [_tableView reloadData];
    }];
}

#pragma mark - tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _credentialsModel.credentials.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RGCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[RGCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    RGCredentialsEntity *credential = _credentialsModel.credentials[indexPath.row];
    cell.titleLabel.text = credential.string;
    
    if (credential.type == CredentialTypeEmail)
        cell.iconImage.image = [UIImage imageNamed:@"envelope.png"];
    
    if (credential.type == CredentialTypeTwitter)
        cell.iconImage.image = [UIImage imageNamed:@"bird.png"];
    
    if (credential.type == CredentialTypeURL)
        cell.iconImage.image = [UIImage imageNamed:@"compass.png"];
    
    return cell;
    
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RGCredentialsEntity *credential = _credentialsModel.credentials[indexPath.row];

    NSString *title = nil;
    
    if (credential.type == CredentialTypeEmail)
        title = @"Compose Email?";
    
    if (credential.type == CredentialTypeTwitter)
        title = @"Follow?";
    
    if (credential.type == CredentialTypeURL)
        title = @"Go to Interwebs?";
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: title
                          message:nil
                          delegate: nil
                          cancelButtonTitle:@"No!!"
                          otherButtonTitles:@"Sure!", nil];
    [alert show];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
