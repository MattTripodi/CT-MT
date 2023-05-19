#import <Foundation/Foundation.h>
#import "CleverTap.h"

@class CleverTap;

@protocol CleverTapDomainDelegate <NSObject>
@optional
/*!
 @method
 
 @abstract
 When conformed to `CleverTapDomainDelegate`, domain available callback will be received if domain available
 
 @param domain the domain to be used by DC SDK
 */
- (void)onDCDomainAvailable:(NSString* _Nonnull)domain;

/*!
 @method
 
 @abstract
 When conformed to `CleverTapDomainDelegate`, domain unavailable callback will be received if domain not available
 */
- (void)onDCDomainUnavailable;
@end

@interface CleverTap (DCDomain)
@end
