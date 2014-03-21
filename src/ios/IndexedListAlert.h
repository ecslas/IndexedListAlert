//
//  IndexedTableView.h
//  ABCplugin
//
//  Created by Ecsedi László on 2014.03.20..
//  Copyright (c) 2014 Ecsedi László. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "DataGenerator.h"

@interface IndexedListAlert : UIAlertView <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>{
    NSArray *inputArray;
    NSMutableArray *contentArray;
    NSMutableArray *indexArray;
    BOOL hasSectionTitle;
}

- (void)setContentAndShow:(NSArray*)paramArray withSectionTitle:(BOOL)hasTitle;

@end
