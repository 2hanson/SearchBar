//
//  Created by hanson on 12/30/12.
//  Copyright (c) 2012 com. All rights reserved.
//

#import "SearchInputField.h"

@implementation SearchInputField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// placeholder position
- (CGRect)textRectForBounds:(CGRect)bounds {
    //I'm sorry, here remains many magic number
    bounds.origin.y += 8;
    bounds.origin.x += 36;
    bounds.size.height += 2;
    bounds.size.width -= 58;

    return CGRectInset( bounds , 0 , 0);
}

// text position
- (CGRect)editingRectForBounds:(CGRect)bounds {
    bounds.origin.y += 8;
    bounds.origin.x += 36;
    bounds.size.height += 2;
    bounds.size.width -= 58;
    
    return CGRectInset( bounds , 0 , 0);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
