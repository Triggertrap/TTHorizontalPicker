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

@property (nonatomic, assign) IBOutlet HorizontalPicker *horizontalPickerWithOneRow;

@property (nonatomic, assign) IBOutlet UILabel *oneRowIndexLabel;
@property (nonatomic, assign) IBOutlet UILabel *oneRowValueLabel;
@property (nonatomic, assign) IBOutlet UILabel *oneRowStringLabel;

@property (nonatomic, assign) IBOutlet HorizontalPicker *horizontalPickerWithTwoRow;

@property (nonatomic, assign) IBOutlet UILabel *twoRowIndexLabel;
@property (nonatomic, assign) IBOutlet UILabel *twoRowValueLabel;
@property (nonatomic, assign) IBOutlet UILabel *twoRowStringLabel;

@end

@implementation ViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *shutterSpeeedValues = [[NSBundle mainBundle] pathForResource:@"ShutterSpeeds" ofType:@"plist"];
    [self.horizontalPickerWithOneRow setDelegate:self];
    [self.horizontalPickerWithOneRow setDataSource:[NSArray arrayWithContentsOfFile:shutterSpeeedValues]];
    [self.horizontalPickerWithOneRow setMinimumValue:[NSNumber numberWithInteger:67]];
    [self.horizontalPickerWithOneRow setMaximumValue:[NSNumber numberWithInteger:600]];
    [self.horizontalPickerWithOneRow setDefaultIndex:1];
    
    // Optional - You can change the gradient, horizontal and vertical lines color
    [self.horizontalPickerWithOneRow gradientViewLeftGradientStarColor:[UIColor redColor]];
    [self.horizontalPickerWithOneRow gradientViewLeftGradientEndColor:[UIColor colorWithWhite:1.0 alpha:0.0]];
    
    [self.horizontalPickerWithOneRow gradientViewRightGradientStarColor:[UIColor redColor]];
    [self.horizontalPickerWithOneRow gradientViewRightGradientEndColor:[UIColor colorWithWhite:1.0 alpha:0.0]];
    [self.horizontalPickerWithOneRow horizontalLinesColor:[UIColor blackColor]];
    [self.horizontalPickerWithOneRow verticalLinesColor:[UIColor blackColor]];
    
    // Change the direction of the gradient by setting the gradient direction
    [self.horizontalPickerWithOneRow gradientDirection:(GradientDirection)TopToBottom];
    
    NSString *shutterSpeeedValuesForTwoRows = [[NSBundle mainBundle] pathForResource:@"NDFilter" ofType:@"plist"];
    [self.horizontalPickerWithTwoRow setDelegate:self];
    [self.horizontalPickerWithTwoRow setDataSource:[NSArray arrayWithContentsOfFile:shutterSpeeedValuesForTwoRows]];
    [self.horizontalPickerWithTwoRow setMinimumValue:[NSNumber numberWithInteger:1]];
    [self.horizontalPickerWithTwoRow setMaximumValue:[NSNumber numberWithInteger:10]];
    [self.horizontalPickerWithTwoRow setDefaultIndex:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - HorizontalPickerDelegate

- (void)horizontalPicker:(id)horizontalPicker didSelectObjectFromDataSourceAtIndex:(NSInteger)index {
    
    if ((HorizontalPicker *)horizontalPicker == self.horizontalPickerWithOneRow) {
        self.oneRowIndexLabel.text = [NSString stringWithFormat:@"%ld", (long)index];
    } else if ((HorizontalPicker *)horizontalPicker == self.horizontalPickerWithTwoRow) {
        self.twoRowIndexLabel.text = [NSString stringWithFormat:@"%ld", (long)index];
    }
}

- (void)horizontalPicker:(id)horizontalPicker didSelectString:(NSString *)string {
    
    if ((HorizontalPicker *)horizontalPicker == self.horizontalPickerWithOneRow) {
        self.oneRowStringLabel.text = string;
    }
}

- (void)horizontalPicker:(id)horizontalPicker didSelectString1:(NSString *)string {
    if ((HorizontalPicker *)horizontalPicker == self.horizontalPickerWithTwoRow) {
        self.twoRowStringLabel.text = string;
    }
}
- (void)horizontalPicker:(id)horizontalPicker didSelectValue:(NSNumber *)value {
    
    if ((HorizontalPicker *)horizontalPicker == self.horizontalPickerWithOneRow) {
        self.oneRowValueLabel.text = [NSString stringWithFormat:@"%@", value];
    } else if ((HorizontalPicker *)horizontalPicker == self.horizontalPickerWithTwoRow) {
        self.twoRowValueLabel.text = [NSString stringWithFormat:@"%@", value];
    }
}

@end
