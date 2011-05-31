//
//  MHConvMessage.m
//  Convore
//
//  Created by Mikael Hallendal on 2011-02-15.
//  Copyright 2011 Mikael Hallendal. All rights reserved.
//

#import "MHConvoreMessage.h"
#import "MHConvoreTopic.h"
#import "MHConvoreUser.h"

@implementation MHConvoreMessage
@synthesize user;
@synthesize topic;
@synthesize groupId;
@synthesize date;
@synthesize messageId;
@synthesize message;
@synthesize renderedMessage;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
  // NSLog(@"Init with dictionary: %@", dict);
    
    self.message = [dict valueForKey:@"message"];
    // self.renderedMessage = [dict valueForKey:@"rendered"];
   
    // Seems to sometimes get ID as NSNumber from JSON
    self.messageId = [[dict valueForKey:@"id"] description];
    self.groupId = [[dict valueForKey:@"group"] stringValue];
    if ([dict objectForKey:@"user"] != nil){
    self.user = [[[MHConvoreUser alloc] initWithDictionary:[dict valueForKey:@"user"]] autorelease];
    }
    if ([dict objectForKey:@"topic"] != nil){
      self.topic = [[[MHConvoreTopic alloc] initWithDictionary:[dict valueForKey:@"topic"]] autorelease];
    }   
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dict andUser:(MHConvoreUser *)aUser withDate:(NSDate *)aDate {
  self.message = [dict valueForKey:@"message"];
  self.messageId = [[dict valueForKey:@"id"] description];
  self.user = aUser;
  // self.date = aDate;
  return self;
}


- (void)dealloc
{
    [super dealloc];
}

@end
