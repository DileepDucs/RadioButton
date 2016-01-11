//
//  RadioButton.m
//  BEATBOOK
//
//  Created by Taj Ahmed on 04/11/15.
//  Copyright © 2015 MOBINEERS. All rights reserved.
//

#import "RadioButton.h"
#import "SoapManager.h"
#import "IUVConstantsPadding.h"
#define IUVRadioButtonWidth 20
#define IUVRadioButtonHeight 20
@implementation RadioButton

@synthesize btnRadioButton,lblTitle,delegate;

- (instancetype)init {
    self = [super init];
    if (self) {
        self.btnRadioButton = [[UIButton alloc] init];
        self.lblTitle = [[UILabel alloc] init];
        [self.btnRadioButton setImage:[UIImage imageNamed:@"radio2.On"] forState:UIControlStateNormal];
        [self.btnRadioButton setImage:[UIImage imageNamed:@"radio2.Off"] forState:UIControlStateNormal];
    }
    return self;
}

+(instancetype)radioButtonWithTitle:(NSString *)title frame:(CGRect)frame selected:(BOOL)selected{
    RadioButton *radioButton = [[RadioButton alloc] init];
    radioButton.frame = frame;
    [radioButton setAccessibilityLabel:@"radioButton"];
    [radioButton.btnRadioButton setFrame:CGRectMake(50, IUVTopPadding, IUVRadioButtonWidth, IUVRadioButtonHeight)];
    radioButton.btnRadioButton.selected = selected;
    [radioButton.btnRadioButton setBackgroundImage:[UIImage imageNamed:@"radio2Off"] forState:UIControlStateNormal];
    [radioButton.btnRadioButton setBackgroundImage:[UIImage imageNamed:@"radio2On"] forState:UIControlStateSelected];
    [radioButton.btnRadioButton setAccessibilityLabel:title];
    [radioButton.btnRadioButton addTarget:radioButton action:@selector(toggleSelected:) forControlEvents:UIControlEventTouchDown];
    radioButton.lblTitle.text = title;
    radioButton.lblTitle.textAlignment = NSTextAlignmentLeft;
    radioButton.lblTitle.font = [UIFont fontWithName:@"Courier" size:13.0];
    radioButton.lblTitle.frame = CGRectMake(80, frame.size.height/2, 120, 16);
    radioButton.backgroundColor = [UIColor clearColor];
    [ViewManager setAutoresizingMaskForView:radioButton.lblTitle left:YES right:NO top:YES bottom:NO height:YES width:YES];
    [ViewManager setAutoresizingMaskForView:radioButton.btnRadioButton left:YES right:NO top:YES bottom:NO height:YES width:YES];
    [radioButton addSubview:radioButton.lblTitle];
    [radioButton addSubview:radioButton.btnRadioButton];
    [radioButton.lblTitle sizeToFit];
    return radioButton;
}

-(void)toggleSelected:(UIButton*)button{
    [self.btnRadioButton setSelected:![self.btnRadioButton isSelected]];
    if ([delegate respondsToSelector:@selector(radioButton:didSelectRadioButton:checked:)]) {
        [delegate radioButton:self didSelectRadioButton:[button accessibilityLabel] checked:[button isSelected]];
    }
}

@end
