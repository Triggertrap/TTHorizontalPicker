//
//  HorizontalPicker.m
//  TTHorizontalPicker
//
//  Created by Valentin Kalchev on 14/08/2014.
//  Copyright (c) 2014 Triggertrap. All rights reserved.
//

#import "TTHorizontalPicker.h"

#define TTHorizontalPickerFont [UIFont fontWithName:@"OpenSans" size:11.0f]

@interface TTHorizontalPicker () {
    NSIndexPath *lastIndexSelected;
    TTGradientView *gradientView;
}

@property (strong, nonatomic) NSNumber *absoluteMinimumValue;
@property (strong, nonatomic) NSNumber *absoluteMaximumValue;

@property (nonatomic) float value;
@property (strong, nonatomic) NSString *valueString;
@property (strong, nonatomic) UICollectionView *collectionView;

@end

@implementation TTHorizontalPicker

#pragma mark - Lifecycle

- (id)initWithCoder:(NSCoder *)coder {
    
    self = [super initWithCoder:coder];
    
    if (self) {
        
        self.autoresizesSubviews = YES;
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal]; 
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [self width], [self height]) collectionViewLayout:flowLayout];
        [self.collectionView setDataSource:self];
        [self.collectionView setDelegate:self];
        [self.collectionView setShowsHorizontalScrollIndicator:NO];
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"HorizontalPickerCell"];
        [self.collectionView setDecelerationRate:UIScrollViewDecelerationRateFast];
        self.collectionView.backgroundColor = [UIColor clearColor];
        self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self addSubview:self.collectionView];
        
        gradientView = [[TTGradientView alloc] initWithFrame:CGRectMake(0, 0, [self width], [self height])];
        gradientView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        gradientView.backgroundColor = [UIColor clearColor];
        gradientView.userInteractionEnabled = NO;
        
        [self addSubview:gradientView];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //Causes collection view items to redraw with new frame when view rotates
    [self.collectionView reloadData];
    [self.collectionView selectItemAtIndexPath:lastIndexSelected animated:NO scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    
    //Causes the gradient view to re-draw with new frame when view rotates instead of stretching it
    [gradientView setNeedsDisplay];
}

#pragma mark - Public

- (void)refreshCurrentIndex {
    [self setCurrentIndex:self.currentIndex];
}

- (void)gradientViewLeftGradientStarColor:(UIColor *)color {
    gradientView.leftGradientStartColor = color;
}

- (void)gradientViewLeftGradientEndColor:(UIColor *)color {
    gradientView.leftGradientEndColor = color;
}

- (void)gradientViewRightGradientStarColor:(UIColor *)color {
    gradientView.rightGradientStartColor = color;
}

- (void)gradientViewRightGradientEndColor:(UIColor *)color {
    gradientView.rightGradientEndColor = color;
}

- (void)horizontalLinesColor:(UIColor *)color {
    gradientView.horizontalLinesColor = color;
}

- (void)verticalLinesColor:(UIColor *)color {
    gradientView.verticalLinesColor = color;
}

- (void)gradientDirection:(GradientDirection)direction {
    gradientView.direction = direction;
}

#pragma mark - ScrollView Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidFinishScrolling:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
   
    if (!decelerate) {
        [self scrollViewDidFinishScrolling:scrollView];
    }
}

- (void)scrollViewDidFinishScrolling:(UIScrollView *)scrollView {
    CGPoint point = [self convertPoint:CGPointMake(([self width] / 2.0f), ([self height] / 2.0f)) toView:self.collectionView];
    
    NSIndexPath *centerIndexPath = [self.collectionView indexPathForItemAtPoint:point];
    
    if (self.minimumValue != nil && self.maximumValue != nil) {
        [self.collectionView selectItemAtIndexPath:centerIndexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    }
    
    if (centerIndexPath.row != self.currentIndex.row) {
        [self setCurrentIndex:centerIndexPath];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.frame.size.width / 3.0f, self.frame.size.height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, [self width] / 3, 0, [self width] / 3);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
} 

#pragma mark - UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (self.minimumValue == nil || self.maximumValue == nil) {
        return 0;
    } else {
        return [self.dataSource count];
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HorizontalPickerCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    
    if ([[self.dataSource objectAtIndex:indexPath.row] objectForKey:@"string1"]) {
        
        for (UIView *subview in [cell.contentView subviews]) {
            [subview removeFromSuperview];
        }
        
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 4, [self width] / 3, [self height] / 2)];
        
        [self setLabel:textLabel withText:[[self.dataSource objectAtIndex:indexPath.row] objectForKey:@"string"]];
        [textLabel setAdjustsFontSizeToFitWidth:YES];
        [textLabel setMinimumScaleFactor:0.5f];
        
        [cell.contentView addSubview:textLabel];
        
        UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, [self height] / 2 - 8, [self width] / 3, [self height] / 2)];
        
        [self setLabel:detailLabel withText:[[self.dataSource objectAtIndex:indexPath.row] objectForKey:@"string1"]];
       
        [cell.contentView addSubview:detailLabel];
    } else {
        
        for (UIView *subview in [cell.contentView subviews]) {
            [subview removeFromSuperview];
        }
        
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [self width] / 3, [self height])];
        
        [self setLabel:textLabel withText:[[self.dataSource objectAtIndex:indexPath.row] objectForKey:@"string"]];
        
        [cell.contentView addSubview:textLabel];
    }
    
    return cell;
}

- (void)setLabel:(UILabel *)label withText:(NSString *)text {
    
    label.textAlignment = NSTextAlignmentCenter;
    label.text = text;
    label.textColor = [UIColor blackColor];
    
    if (self.font) {
        label.font = self.font;
    }
    
    if (self.fontColor) {
        label.textColor = self.fontColor;
    }
    
    [label setAdjustsFontSizeToFitWidth:YES];
    [label setMinimumScaleFactor:0.5f];
}

#pragma mark - Getters 

- (float)width {
    return self.frame.size.width;
}

- (float)height {
    return self.frame.size.height;
}

- (NSUInteger)indexOfDictionaryForValue:(NSNumber *)value {
    
    if (value != nil) {
        for (NSDictionary *dict in self.dataSource) {
            if ([[dict objectForKey:@"value"] isEqualToNumber:value]) {
                return [self.dataSource indexOfObjectIdenticalTo:dict];
                break;
            } else {
                continue;
            }
        }
    }
    
    return 0;
}

- (NSInteger)savedIndexForKey:(NSString *)identifier {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // We do it like this to tell the difference between a missing key, and a stored value of 0.0;
    if ([defaults objectForKey:identifier] != nil) {
        NSNumber *num = [defaults objectForKey:identifier];
        return num.integerValue;
    } else {
        return self.defaultIndex;
    }
}

#pragma mark - Setters 

- (void)setDataSource:(NSArray *)dataSource {
    self->_dataSource = dataSource;
    
    if (dataSource != nil && ([dataSource count] > 0)) {
        self.absoluteMinimumValue = [[dataSource objectAtIndex:0] objectForKey:@"value"];
        self.absoluteMaximumValue = [[dataSource objectAtIndex:([dataSource count] - 1)] objectForKey:@"value"];
    }
}

- (void)setMinimumValue:(NSNumber *)minimumValue {
    NSInteger value = [minimumValue integerValue];
    
    if (self.dataSource != nil && [self.dataSource count] >= 1) {
        // check that the value is not smaller than the minimum value of our datasource
        if (value < [self.absoluteMinimumValue integerValue]) {
            value = [self.absoluteMinimumValue integerValue];
        }
        
        self->_minimumValue = [NSNumber numberWithInteger:value];
        
        if (self.currentIndex != nil) {
            [self.collectionView reloadData];
        }
    } else {
        return;
    }
}

- (void)setMaximumValue:(NSNumber *)maximumValue {
    NSInteger value = [maximumValue integerValue];
    
    if (self.dataSource != nil && [self.dataSource count] >= 1) {
        // check that the value is not larger than the maximum value of our datasource
        if (value > [self.absoluteMaximumValue integerValue]) {
            value = [self.absoluteMaximumValue integerValue];
        }
        
        self->_maximumValue = [NSNumber numberWithInteger:value];
        
        if (self.currentIndex != nil) {
            [self.collectionView reloadData];
        }
    } else {
        return;
    }
}

- (void)setCurrentIndex:(NSIndexPath *)currentIndex {
    self->_currentIndex = currentIndex;
    
    if (self.minimumValue) {
        if (self.currentIndex.row < [self indexOfDictionaryForValue:self.minimumValue]) {
            self->_currentIndex = [NSIndexPath indexPathForRow:[self indexOfDictionaryForValue:self.minimumValue] inSection:0];
        }
    }
    
    if (self.maximumValue) {
        if (self.currentIndex.row > [self indexOfDictionaryForValue:self.maximumValue]) {
            self->_currentIndex = [NSIndexPath indexPathForRow:[self indexOfDictionaryForValue:self.maximumValue] inSection:0];
        }
    }
    
    if (self.currentIndex != nil) {
        [self updateForSelectedIndex];
    }
}

- (void)updateForSelectedIndex {
    
    if (self.minimumValue != nil && self.maximumValue != nil) {
        [self.collectionView reloadData];
        [self.collectionView scrollToItemAtIndexPath:self.currentIndex atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        
        NSDictionary *dict = [self.dataSource objectAtIndex:self.currentIndex.row];
        
        self.value = [[dict objectForKey:@"value"] floatValue];
        self.valueString = [dict objectForKey:@"string"];
        
        [self updateDelegateForIndex:self.currentIndex];
    } else {
        return;
    }
}
- (void)saveIndex:(NSInteger)index forKey:(NSString *)identifier {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *num = [NSNumber numberWithInteger:index];
    [defaults setObject:num forKey:identifier];
    [defaults synchronize];
}

#pragma mark - Delegate Callbacks

- (void)updateDelegateForIndex:(NSIndexPath *)currentIndex {
    lastIndexSelected = currentIndex;
    
    if ([self.delegate respondsToSelector:@selector(horizontalPicker:didSelectObjectFromDataSourceAtIndex:)]) {
        [self.delegate horizontalPicker:self didSelectObjectFromDataSourceAtIndex:currentIndex.row];
    }
    
    NSDictionary *dict = [self.dataSource objectAtIndex:currentIndex.row];
    
    if ([self.delegate respondsToSelector:@selector(horizontalPicker:didSelectValue:)]) {
        [self.delegate horizontalPicker:self didSelectValue:[dict objectForKey:@"value"]];
    }
    
    if ([self.delegate respondsToSelector:@selector(horizontalPicker:didSelectString:)]) {
        [self.delegate horizontalPicker:self didSelectString:[dict objectForKey:@"string"]];
    }
    
    if ([self.delegate respondsToSelector:@selector(horizontalPicker:didSelectString1:)]) {
        [self.delegate horizontalPicker:self didSelectString1:[dict objectForKey:@"string1"]];
    }
} 

@end
