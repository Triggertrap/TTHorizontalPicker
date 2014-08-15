//
//  ViewController.m
//  TTHorizontalPicker
//
//  Created by Valentin Kalchev on 12/08/2014.
//  Copyright (c) 2014 Triggertrap. All rights reserved.
//

#import "ViewController.h"
#import "HorizontalPicker.h"

@interface ViewController () <HorizontalPickerDelegate>

@property (nonatomic, assign) IBOutlet HorizontalPicker *collectionView;
@property (nonatomic, assign) IBOutlet HorizontalPicker *collectionViewWithTwoRows;

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString *shutterSpeeedValues = [[NSBundle mainBundle] pathForResource:@"ShutterSpeeds" ofType:@"plist"];
    [self.collectionView setDelegate:self];
    [self.collectionView setDataSource:[NSArray arrayWithContentsOfFile:shutterSpeeedValues]];
    [self.collectionView setMinimumValue:[NSNumber numberWithInteger:67]];
    [self.collectionView setMaximumValue:[NSNumber numberWithInteger:6800000]];
    [self.collectionView setDefaultIndex:2];   
    
    NSString *shutterSpeeedValuesForTwoRows = [[NSBundle mainBundle] pathForResource:@"NDFilter" ofType:@"plist"];
    [self.collectionViewWithTwoRows setDelegate:self];
    [self.collectionViewWithTwoRows setDataSource:[NSArray arrayWithContentsOfFile:shutterSpeeedValuesForTwoRows]];
    [self.collectionViewWithTwoRows setMinimumValue:[NSNumber numberWithInteger:1]];
    [self.collectionViewWithTwoRows setMaximumValue:[NSNumber numberWithInteger:20]];
    [self.collectionViewWithTwoRows setDefaultIndex:2];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
