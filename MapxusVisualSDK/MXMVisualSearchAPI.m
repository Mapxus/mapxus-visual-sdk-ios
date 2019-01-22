//
//  MXMVisualSearchAPI.m
//  MapxusVisualSDK
//
//  Created by Chenghao Guo on 2018/11/30.
//  Copyright © 2018年 MAPHIVE TECHNOLOGY LIMITED. All rights reserved.
//

#import "MXMVisualSearchAPI.h"
#import "MXMHttpManager.h"
#import "MXMNodelist.h"
#import "JXJsonFunctionDefine.h"
#import <YYModel/YYModel.h>

@implementation MXMVisualSearchAPI

- (void)searchNodesOnBuilding:(NSString *)buildingId
{
    NSString *url = [NSString stringWithFormat:@"https://vis-api.maphive.cloud/graphql"];
    
    NSString *str = [NSString stringWithFormat:@"{\"query\":\"query {\\n  building(key:\\\"%@\\\"){    \\n    floor{\\n      code\\n    }\\n    images{\\n      key\\n      l{\\n        lat\\n        lon\\n      }\\n      building{\\n        id\\n      }\\n      floor{\\n        code\\n      }\\n      ca\\n    }\\n  }\\n}\\n\"}", buildingId];
    
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    [MXMHttpManager MXMPOST:url data:data success:^(NSDictionary *content) {
        NSDictionary *data = DecodeDicFromDic(content, @"data");
        NSArray *listJson = DecodeArrayFromDic(data, @"building");
        NSArray *list = [NSArray yy_modelArrayWithClass:[MXMNodelist class] json:listJson];
        if (self.delegate && [self.delegate respondsToSelector:@selector(visualNodesSearchSuccess:)]) {
            [self.delegate visualNodesSearchSuccess:list];
        }
    } failure:^(NSError *error) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(visualSearchFailure:)]) {
            [self.delegate visualSearchFailure:error];
        }
    }];

}

@end
