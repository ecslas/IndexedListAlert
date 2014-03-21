//
//  IndexedTableView.m
//  ABCplugin
//
//  Created by Ecsedi László on 2014.03.20..
//  Copyright (c) 2014 Ecsedi László. All rights reserved.
//

#import "IndexedListAlert.h"

@implementation IndexedListAlert

static NSInteger comparator(id a, id b, void* context)
{
    NSInteger options = NSCaseInsensitiveSearch
    | NSNumericSearch              // Numbers are compared using numeric value
    //| NSDiacriticInsensitiveSearch // Ignores diacritics (â == á == a)
    | NSWidthInsensitiveSearch;    // Unicode special width is ignored
    
    return [(NSString*)a compare:b options:options];
}

- (void)setContentAndShow:(NSArray*)paramArray withSectionTitle:(BOOL)hasTitle{
    
    inputArray = paramArray;
    
    //[[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObject:@"hu_HU"] forKey:@"AppleLanguages"];
    //NSArray* sortedArray =  [inputArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];//[inputArray sortedArrayUsingFunction:finderSortWithLocale context:nil];
    /*
    NSLocale *locale=[[NSLocale alloc] initWithLocaleIdentifier:[[NSLocale preferredLanguages] objectAtIndex:0]];
    NSArray *sortedArray=[inputArray sortedArrayUsingComparator:^(NSString *first, NSString *second) {
        return [first compare:second
                      options:NSCaseInsensitiveSearch | NSNumericSearch | NSWidthInsensitiveSearch
                        range:NSMakeRange(0, [first length])
                       locale:locale];
    }];
    */
     
    NSArray* sortedArray = [inputArray sortedArrayUsingFunction:comparator context:NULL];
    
    hasSectionTitle = hasTitle;
    contentArray = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc] init];
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    for (NSString* index in sortedArray) {
        
        NSString *firstLetter = [index substringToIndex:1];
        firstLetter = [firstLetter uppercaseString];
        
        if(![[tempDictionary objectForKey:@"index"] isEqualToString:firstLetter]){
            if([tempDictionary objectForKey:@"index"] == nil){
                [tempDictionary setObject:firstLetter forKey:@"index"];
                [tempArray addObject:index];
            }
            else{
                [tempDictionary setObject:tempArray forKey:@"value"];
                [contentArray addObject:tempDictionary];
                tempDictionary = [[NSMutableDictionary alloc] init];
                tempArray = [[NSMutableArray alloc] init];
                [tempArray addObject:index];
                [tempDictionary setObject:firstLetter forKey:@"index"];
                [tempDictionary setObject:tempArray forKey:@"value"];
            }
        }
        else{
            [tempArray addObject:index];
        }
    }
    [contentArray addObject:tempDictionary];
    
    indexArray = [contentArray valueForKey:@"index"];
    
    UITableView * table = [[UITableView alloc] initWithFrame:CGRectMake(10, 40, 264, 500)];
    [table setDataSource:self];
    [table setDelegate:self];
    [self setDelegate:self];
    
    [self setValue:table forKey:@"accessoryView"];
    [self show];
}

int finderSortWithLocale(NSString *word1, NSString *word2, void *locale)
{
    static NSStringCompareOptions comparisonOptions = NSNumericSearch;
    
    NSRange string1Range = NSMakeRange(0, [word1 length]);
    return [word1 compare:word2
                 options:comparisonOptions
                   range:string1Range
                  locale:[NSLocale currentLocale]];
}

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [contentArray count];
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[contentArray objectAtIndex:section] objectForKey:@"value"] count] ;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [[[contentArray objectAtIndex:indexPath.section] objectForKey:@"value"]
                           objectAtIndex:indexPath.row];
    
    return cell;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [contentArray valueForKey:@"index"];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return [indexArray indexOfObject:title];
}

- (NSString *)tableView:(UITableView *)aTableView titleForHeaderInSection:(NSInteger)section {
    if(hasSectionTitle){
        return [[contentArray objectAtIndex:section] objectForKey:@"index"];
    }
    else{
        return nil;
    }
}


@end
