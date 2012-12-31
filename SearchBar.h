//
//  Created by hanson on 12/29/12.
//  Copyright (c) 2012 com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchInputField.h"
#import "SearchReloadTableDelegate.h"

@interface SearchBar : UIView<UISearchBarDelegate>
{
    UIImageView *background;
    UIImageView *searchIcon;
    UIButton *cancelBtn;
    UIButton *clearTextBtn;
    UIButton *suicideBtn;
    SearchInputField *inputField;
    
    UITextView *textInternalView;

    NSMutableArray *itemsList;
    NSMutableArray *searchedList;

    //myself's datastruct
    NSMutableArray * listArr;
    NSMutableDictionary * listDic;
    NSMutableArray * searchedListArr;
    NSMutableDictionary * searchedListDic;
    
    NSObject<SearchReloadTableDelegate> *searchReloadTableDelegate;

}

@property (nonatomic, retain) NSObject<SearchReloadTableDelegate> *searchReloadTableDelegate;
@property (nonatomic, retain) NSMutableArray * listArr;
@property (nonatomic, retain) NSMutableDictionary * listDic;
@property (nonatomic, retain) NSArray* SEARCHKEYFIELDS;

-(void) StartSearch;
-(void) Suicide;
- (void) keyboardWillShown:(NSNotification*) aNotification;
- (void) keyboardDidShown:(NSNotification*) aNotification;
- (void)keyboardWasHidden:(NSNotification*)aNotification;
@end
