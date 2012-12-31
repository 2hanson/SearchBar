SearchBar
=========

IOS SearchBar. Compatible with IOS 6.0 and later, of course can compatible with all the early version.

## Example Usage

``` objective-c
SearchBar *barItem = [[SearchBar alloc] init];
barItem.frame = CGRectMake(0, 0, 320, 56);
AgendaTableView *atv = (AgendaTableView*)_swipeView.currentItemView;
barItem.searchReloadTableDelegate = atv;
barItem.listArr = atv.listArr;
barItem.listDic = atv.listDic;
    
[self.view addSubview:barItem];
```

License
=========
SearchBar is available under the MIT license. See the LICENSE file for more info.
