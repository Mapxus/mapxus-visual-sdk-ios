//
//  MXMVisualSearch.m
//  MapxusVisualSDK
//
//  Created by Chenghao Guo on 2019/9/11.
//  Copyright © 2019 MAPHIVE TECHNOLOGY LIMITED. All rights reserved.
//

#import "MXMVisualSearch.h"
#import "MXMHttpManager.h"
#import "MXMNodeGroup.h"
#import "JXJsonFunctionDefine.h"
#import <YYModel/YYModel.h>
#import "MXMConstants.h"

@implementation MXMVisualSearch

- (NSInteger)searchVisualDataInBuilding:(MXMVisualBuildingSearchOption *)option {
    
    NSString *url = [NSString stringWithFormat:@"%@/vis/graphql", MXMAPIHOSTURL];
    
    NSString *str = @"";
    switch (option.scope) {
            case MXMVisualSearchScopeDetail:
        {
            str = [NSString stringWithFormat:@"{\"query\":\"query {\\n  building(key:\\\"%@\\\"){    \\n    floor{\\n      code\\n    }\\n    images{\\n      key\\n      l{\\n        lat\\n        lon\\n      }\\n      building{\\n        id\\n      }\\n      floor{\\n        code\\n      }\\n      ca\\n    }\\n  }\\n}\\n\"}", option.buildingId];
            break;
        }
            case MXMVisualSearchScopeSimple:
        {
            str = [NSString stringWithFormat:@"{\"query\":\"query {\\n  building(key:\\\"%@\\\"){    \\n    floor{\\n      code\\n    }\\n }\\n}\\n\"}", option.buildingId];
            break;
        }
        default:
            break;
    }
    
    
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    NSURLSessionTask *task = [MXMHttpManager MXMPOST:url data:data success:^(NSDictionary *content) {
        NSDictionary *data = DecodeDicFromDic(content, @"data");
        NSArray *listJson = DecodeArrayFromDic(data, @"building");
        NSArray *list = [NSArray yy_modelArrayWithClass:[MXMNodeGroup class] json:listJson];
        if (self.delegate && [self.delegate respondsToSelector:@selector(onGetVisualDataInBuilding:result:error:)]) {
            [self.delegate onGetVisualDataInBuilding:self
                                              result:list
                                               error:nil];
        }
    } failure:^(NSError *error) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(onGetVisualDataInBuilding:result:error:)]) {
            [self.delegate onGetVisualDataInBuilding:self
                                              result:nil
                                               error:error];
        }
    }];
    
    return task.taskIdentifier;
}

@end
