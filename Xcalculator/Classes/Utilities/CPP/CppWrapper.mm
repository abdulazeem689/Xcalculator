//
//  CppWrapper.m
//  Xcalculator
//
//  Created by Abdul Azeem on 28/08/20.
//  Copyright © 2020 Mindfire. All rights reserved.
//

#import "CppWrapper.h"
#import "CppCode.hpp"

@implementation CppWrapper

-(double) evaluate: (NSString *) s
{
    CppClass cppClass;
    return cppClass.evaluate([s UTF8String]);
}

@end
