//
//  ControlRadioButton.m
//  BEATBOOK
//
//  Created by Taj Ahmed on 04/11/15.
//  Copyright © 2015 MOBINEERS. All rights reserved.
//

#import "ControlRadioButton.h"
#import "IUVLogger.h"
#import "IUVConstantsPadding.h"

@interface ControlRadioButton ()

@property(nonatomic, strong) NSMutableArray<NSString*> *radiobuttonItems;
@property(nonatomic, strong) NSMutableArray<RadioButton*> *radiobuttons;
@property(nonatomic, strong) UILabel *lblTitle;
@property(nonatomic, strong) NSString* selectedButtonTitle;

@end


@implementation ControlRadioButton

@synthesize radiobuttons,lblTitle,controlId,radiobuttonItems,selectedButtonTitle;

- (instancetype)init
{
    self = [super init];
    if (self) {
        CGRect labelFrame = CGRectMake(IUVLeftPadding, IUVOriginY  ,120 , 30);
        self.lblTitle = [[UILabel alloc] initWithFrame:labelFrame];
        self.radiobuttons = [[NSMutableArray alloc] init];
        self.radiobuttonItems = [[NSMutableArray alloc] init];
        selectedButtonTitle = @"";
    }
    [self layoutLabel:self.lblTitle];
    [self sizeToFit];
    return self;
}

-(void)plot:(id)infoDictionary{
    self.radiobuttonItems = [[[infoDictionary valueForKey:@"radiobuttonItems"] componentsSeparatedByString:@","] mutableCopy];
    self.controlId = [[infoDictionary valueForKey:@"controlId"] integerValue];
    CGRect radiobuttonFrame = CGRectMake(self.lblTitle.frame.size.width, IUVOriginY, 120, 30);
    if (![radiobuttons count]) {
        for (NSString *radioButtonTitle in self.radiobuttonItems) {
            RadioButton *radioButton = [RadioButton radioButtonWithTitle:radioButtonTitle frame:radiobuttonFrame selected:NO];
            [radioButton setDelegate:self];
            radiobuttonFrame.origin.y += 30;
            [self addSubview:radioButton];
            [self.radiobuttons addObject:radioButton];
        }
        selectedButtonTitle = [self.radiobuttonItems firstObject];
        [[[radiobuttons firstObject] btnRadioButton] setSelected:YES];
        UIViewController *viewController = ((UINavigationController*)[UIApplication sharedApplication].delegate.window.rootViewController);
        [self setFrame:CGRectMake(10, 0, viewController.view.frame.size.width, 30*self.radiobuttons.count)];
        [self.lblTitle setFrame:CGRectMake(IUVOriginX, self.center.y-15, 120, 30)];
        [self.lblTitle setText:[infoDictionary valueForKey:@"radiobuttonTitle"]];
        [self.lblTitle sizeToFit];
    }
}

-(id)readValue{
    NSDictionary* values = [NSDictionary dictionaryWithObjectsAndKeys:selectedButtonTitle,@"value",@(self.controlId),@"controlId", nil];
    return values;
}

-(void)reset{
    for (RadioButton* radioButton in radiobuttons) {
        [[radioButton btnRadioButton] setSelected:NO];
    }
    [[[radiobuttons firstObject] btnRadioButton] setSelected:YES];
    selectedButtonTitle = [radiobuttonItems firstObject];
}

#pragma mark - <RadioButtonDelegate> implementation

-(void)radioButton:(RadioButton *)radioButton didSelectRadioButton:(NSString *)title checked:(BOOL)checked{
    for (RadioButton* radioButton in radiobuttons) {
        if (![radioButton.lblTitle.text isEqualToString:title]) {
            [radioButton.btnRadioButton setSelected:NO];
        }
    }
    selectedButtonTitle = [title copy];
}

@end
