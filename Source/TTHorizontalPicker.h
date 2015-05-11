//
//  HorizontalPicker.h
//  TTHorizontalPicker
//
//  Created by Valentin Kalchev on 14/08/2014.
//  Copyright (c) 2014 Triggertrap. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTGradientView.h"

@protocol TTHorizontalPickerDelegate <NSObject>
@optional

/*!
 * Use to send a call back to view controller that will receive the last item index selected from the horizontal picker
 */
- (void)horizontalPicker:(id)horizontalPicker didSelectObjectFromDataSourceAtIndex:(NSInteger)index;

/*!
 * Use to send a call back to view controller that will receive the last item value selected from the horizontal picker
 */
- (void)horizontalPicker:(id)horizontalPicker didSelectValue:(NSNumber *)value;

/*!
 * Use to send a call back to view controller that will receive the last item string (top) selected from the horizontal picker
 */
- (void)horizontalPicker:(id)horizontalPicker didSelectString:(NSString *)string;

/*!
 * Use to send a call back to view controller that will receive the last item string (bottom) selected from the horizontal picker
 */
- (void)horizontalPicker:(id)horizontalPicker didSelectString1:(NSString *)string;

@end

@interface TTHorizontalPicker : UIView <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>
 
@property (strong, nonatomic) id <TTHorizontalPickerDelegate> delegate;

/*!
 * Use to change the horizontal picker text font color
 */
@property (strong, nonatomic) UIColor *fontColor;

/*!
 * Use to change the horizontal picker text font
 */
@property (strong, nonatomic) UIFont *font;

/*!
 * Use to set minimum value that the horizontal picker should display (use "value" string from plist as reference)
 */
@property (strong, nonatomic) NSNumber *minimumValue;

/*!
 * Use to set maximum value that the horizontal picker should display (use "value" string from plist as reference)
 */
@property (strong, nonatomic) NSNumber *maximumValue;

/*!
 * Use to set index in horizontal picker that needs to be displayed
 */
@property (strong, nonatomic) NSIndexPath *currentIndex;

/*!
 * Use to set data source for items in the horizontal picker
 */
@property (strong, nonatomic) NSArray *dataSource;

/*!
 * Use to set default index that needs displaying when horizontal picker becomes visible
 */
@property (nonatomic) NSInteger defaultIndex;

/*!
 * Use to refresh horizontal picker items in case their span has changed
 */
- (void)refreshCurrentIndex;

/*!
 * Use to set left hand side start gradient color
 */
- (void)gradientViewLeftGradientStarColor:(UIColor *)color;

/*!
 * Use to set left hand side end gradient color
 */
- (void)gradientViewLeftGradientEndColor:(UIColor *)color;

/*!
 * Use to set right hand side start gradient color
 */
- (void)gradientViewRightGradientStarColor:(UIColor *)color;

/*!
 * Use to set right hand side end gradient color
 */
- (void)gradientViewRightGradientEndColor:(UIColor *)color;

/*!
 * Use to set horizontal lines (triangle & top line) color
 */
- (void)horizontalLinesColor:(UIColor *)color;

/*!
 * Use to set vertical lines (separating the view into three parts) color
 */
- (void)verticalLinesColor:(UIColor *)color;

/*!
 * Use to set the direction of the gradient (Top to Bottom or Left to Right)
 */
- (void)gradientDirection:(GradientDirection)direction;

/*!
 * Use to get saved index from picker
 */
- (NSInteger)savedIndexForKey:(NSString *)identifier;

/*!
 * Use to save index from picker
 */
- (void)saveIndex:(NSInteger)index forKey:(NSString *)identifier;

@end
