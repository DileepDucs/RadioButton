//
//  ControlRadioButton.h
//  BEATBOOK
//
//  Created by Taj Ahmed on 04/11/15.
//  Copyright © 2015 MOBINEERS. All rights reserved.
//

#import "Control.h"
#import "RadioButton.h"

@interface Control()

- (void)layoutLabel:(UILabel*)label;

@end

@interface ControlRadioButton : Control<RadioButtonDelegate>

@end
