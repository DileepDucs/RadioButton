//
//  RadioButton.h
//  BEATBOOK
//
//  Created by Taj Ahmed on 04/11/15.
//  Copyright © 2015 MOBINEERS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RadioButton;

@protocol RadioButtonDelegate <NSObject>

-(void)radioButton:(RadioButton*)radioButton didSelectRadioButton:(NSString*)title checked:(BOOL)checked;

@end

@interface RadioButton : UIView

@property(nonatomic, strong) id<RadioButtonDelegate> delegate;
@property(nonatomic, strong)UIButton *btnRadioButton;
@property(nonatomic, strong)UILabel *lblTitle;

+(instancetype)radioButtonWithTitle:(NSString*)title frame:(CGRect)frame selected:(BOOL)selected;

@end
