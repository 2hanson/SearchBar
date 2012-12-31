//
//  Created by hanson on 12/29/12.
//  Copyright (c) 2012 com. All rights reserved.
//

#import "searchBar.h"
#import "SearchInputField.h"

@implementation SearchBar

@synthesize searchReloadTableDelegate;
@synthesize listArr;
@synthesize listDic;
@synthesize SEARCHKEYFIELDS;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //search background
        //chartValue = [[UIImageView alloc] ];
        background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchBG.png"]];
        background.backgroundColor = [UIColor grayColor];
        background.frame = CGRectMake(0, 0, 320, 56);
        //[background setBackgroundColor:textColor];
        [self addSubview:background];
        
        //suicideBtn
        suicideBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        suicideBtn.frame = CGRectMake(240, 8, 66, 36);
        [suicideBtn setBackgroundImage:[UIImage imageNamed:@"suicideBtnBG.png"] forState:UIControlStateNormal];
        [suicideBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        suicideBtn.titleLabel.font = FONT_BOLD_SIZE(18);
        [suicideBtn setTitle:@"Cancel" forState:UIControlStateNormal];
        [suicideBtn addTarget:self action:@selector(suicideAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:suicideBtn];
        
        //searchField
        inputField = [[SearchInputField alloc] initWithFrame:CGRectMake(20, 8, 220, 36)];
        inputField.clearButtonMode = UITextFieldViewModeWhileEditing;
        inputField.returnKeyType = UIReturnKeySearch;
        inputField.delegate = (id)self;
        inputField.backgroundColor = [UIColor whiteColor];
        inputField.font = FONT_SIZE(16);
        inputField.textAlignment = UITextAlignmentLeft;
        [inputField setPlaceholder:@"Search"];
        
        UIImageView* paddingView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search.png"]];
        paddingView.frame = CGRectMake(0, 0, 33, 33);

        inputField.leftView = paddingView;
        inputField.leftViewMode = UITextFieldViewModeAlways;
        
        [self addSubview:inputField];
        
        //show keyboard
        [inputField becomeFirstResponder];
        
        [self registerForKeyboardNotifications];
        
        SEARCHKEYFIELDS = [[NSArray alloc] initWithObjects:@"tag", @"title", @"abstraction", @"location", @"audiences", nil];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
#pragma mark -
-(void) StartSearch
{
    [inputField becomeFirstResponder];
}

- (void) search:(NSString *) matchString
{
    
    int index;
    NSArray *tempArr;
    NSDictionary *tempDict;
    NSLog(@"%@", matchString);
    searchedListArr = [[NSMutableArray alloc] init];
    searchedListDic = [[NSMutableDictionary alloc] init];
    
    if ([matchString isEqualToString:@""] == true)
    {
        [[self searchReloadTableDelegate] SearchReloadTable:searchedListArr ListDic:searchedListDic];
        return;
    }
    
    int count = listArr.count;
    for (index = 0; index < count; index++) {
        tempArr = (NSArray *)[listDic objectForKey:[listArr objectAtIndex:index]];
        int tc = tempArr.count;
        NSMutableArray* tempResArr = [[NSMutableArray alloc] init];
        
        for (int ti = 0; ti < tc; ++ti)
        {
            tempDict = (NSDictionary *)[tempArr objectAtIndex:ti];
            id keys;
            keys = [tempDict allKeys];
            for (int keyIndex = 0; keyIndex < [keys count]; ++keyIndex)
            {
                id key = [keys objectAtIndex: keyIndex];
                id value = [tempDict objectForKey: key];
                if (value == nil || value == [NSNull null])
                {
                }
                else if ([[self SEARCHKEYFIELDS] containsObject:key] == true)
                {
                    NSString* searchedField = (NSString*)value;
                    NSRange range = [[searchedField lowercaseString] rangeOfString:[matchString lowercaseString]];

                    //{NSNotFound, 0}
                    if (range.length != 0)
                    {
                        //NSMutableDictionary *tempResDict = [[NSMutableDictionary alloc] init];
                        [tempResArr addObject:tempDict];
                        break;
                    }
                }
            }
        }
        
        if (0 != [tempResArr count])
        {
            [searchedListArr addObject:[self.listArr objectAtIndex:index]];
            [searchedListDic setObject:tempResArr forKey:(NSString*)[self.listArr objectAtIndex:index]];
        }
    }
    
    [[self searchReloadTableDelegate] SearchReloadTable:searchedListArr ListDic:searchedListDic];
}

-(void) suicideAction:(id)sender
{
    [self Suicide];
}

-(void) Suicide
{
    //reset data
    [[self searchReloadTableDelegate] SearchReloadTable:listArr ListDic:listDic];

    [self unRegisterForKeyboardNotifications];
    [self removeFromSuperview];
}

#pragma mark -
#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == inputField)
    {
        //hide keyboard
        [inputField resignFirstResponder];
        
        //
        [self search:textField.text];
    }
    else
    {
    }
    return YES;
}

- (void) keyboardWillShown:(NSNotification*) aNotification
{

}

- (void) keyboardDidShown:(NSNotification*) aNotification
{
    suicideBtn.frame = CGRectMake(240, 8, 66, 36);
    [suicideBtn setBackgroundImage:[UIImage imageNamed:@"suicideBtnBG.png"] forState:UIControlStateNormal];
    [suicideBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    suicideBtn.titleLabel.font = FONT_BOLD_SIZE(18);
    [suicideBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    //    barItem.frame = CGRectMake(0, 0, 320, 60);
    //[background setHidden:FALSE];
}

- (void)keyboardWasHidden:(NSNotification*)aNotification
{
    suicideBtn.frame = CGRectMake(260, 8, 36, 36);
    [suicideBtn setBackgroundImage:[UIImage imageNamed:@"searchClose.png"] forState:UIControlStateNormal];
    [suicideBtn setTitle:@"" forState:UIControlStateNormal];
    //
    //[background setHidden:TRUE];
}

- (void) registerForKeyboardNotifications
{    
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWillShown:)
												 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardDidShown:)
												 name:UIKeyboardDidShowNotification object:nil];
	
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWasHidden:)
												 name:UIKeyboardDidHideNotification object:nil];
}

- (void) unRegisterForKeyboardNotifications
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
