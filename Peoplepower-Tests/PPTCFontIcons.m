//
//  PPTCFontIcons.m
//  PPiOSCore-Tests
//
//  Created by Destry Teeter on 9/28/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface PPTCFontIcons : XCTestCase

@end

@implementation PPTCFontIcons

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}
/* Moved to iOSCoreUI
- (void)testFonts {
    
    UIFont *heavyItalicFont = [PPUIFont heavyItalicSystemFontOfSize:10];
    UIFont *thinItalicFont = [PPUIFont thinItalicSystemFontOfSize:10];
    UIFont *ultralightFont = [PPUIFont ultralightSystemFontOfSize:10];
    UIFont *heavyFont = [PPUIFont heavySystemFontOfSize:10];
    UIFont *boldItalicFont = [PPUIFont boldItalicSystemFontOfSize:10];
    UIFont *semiboldItalicFont = [PPUIFont semiboldItalicSystemFontOfSize:10];
    UIFont *regularFont = [PPUIFont regularSystemFontOfSize:10];
    UIFont *boldFont = [PPUIFont boldSystemFontOfSize:10];
    UIFont *mediumItalicFont = [PPUIFont mediumItalicSystemFontOfSize:10];
    UIFont *thinFont = [PPUIFont thinSystemFontOfSize:10];
    UIFont *semiboldFont = [PPUIFont semiboldSystemFontOfSize:10];
    UIFont *blackItalicFont = [PPUIFont blackItalicSystemFontOfSize:10];
    UIFont *lightFont = [PPUIFont lightSystemFontOfSize:10];
    UIFont *ultralightItalicFont = [PPUIFont ultralightItalicSystemFontOfSize:10];
    UIFont *italicFont = [PPUIFont italicSystemFontOfSize:10];
    UIFont *lightItalicFont = [PPUIFont lightItalicSystemFontOfSize:10];
    UIFont *blackFont = [PPUIFont blackSystemFontOfSize:10];
    UIFont *mediumFont = [PPUIFont mediumSystemFontOfSize:10];
    
    UIFont *IOTIconsFont = [PPUIFont fontIconWithSize:10 type:PPFontIconTypePP];
    UIFont *weatherIconsFont = [PPUIFont fontIconWithSize:10 type:PPFontIconTypeWeather];
    UIFont *fontAwesomeFont = [PPUIFont fontIconWithSize:10 type:PPFontIconTypeFA];
    UIFont *fontAwesomeBrandsFont = [PPUIFont fontIconWithSize:10 type:PPFontIconTypeFABrands];
    
    for (NSString *familyName in [UIFont familyNames]) {
        NSLog(@"familyName: %@", familyName);
        for (NSString *name in [UIFont fontNamesForFamilyName:familyName]) {
            NSLog(@"   name: %@", name);
        }
    }
    NSArray *fonts = @[@{@"HeavyItalic": heavyItalicFont},
                       @{@"ThinItalic": thinItalicFont},
                       @{@"Ultralight": ultralightFont},
                       @{@"Heavy": heavyFont},
                       @{@"BoldItalic": boldItalicFont},
                       @{@"SemiboldItalic": semiboldItalicFont},
                       @{@"Regular": regularFont},
                       @{@"Bold": boldFont},
                       @{@"MediumItalic": mediumItalicFont},
                       @{@"Thin": thinFont},
                       @{@"Semibold": semiboldFont},
                       @{@"BlackItalic": blackItalicFont},
                       @{@"Light": lightFont},
                       @{@"UltralightItalic": ultralightItalicFont},
                       @{@"Italic": italicFont},
                       @{@"LightItalic": lightItalicFont},
                       @{@"Black": blackFont},
                       @{@"Medium": mediumFont},
                       @{@"IOTIcons": IOTIconsFont},
                       @{@"WeatherIcons": weatherIconsFont},
                       @{@"FontAwesome": fontAwesomeFont},
                       @{@"FontAwesomeBrands": fontAwesomeBrandsFont}];
    
    NSArray *contentSizeCategories = @[@{@"AccessibilityExtraExtraExtraLarge": UIContentSizeCategoryAccessibilityExtraExtraExtraLarge},
                                       @{@"AccessibilityExtraExtraLarge": UIContentSizeCategoryAccessibilityExtraExtraLarge},
                                       @{@"AccessibilityExtraLarge": UIContentSizeCategoryAccessibilityExtraLarge},
                                       @{@"AccessibilityLarge": UIContentSizeCategoryAccessibilityLarge},
                                       @{@"AccessibilityMedium": UIContentSizeCategoryAccessibilityMedium},
                                       @{@"ExtraExtraExtraLarge": UIContentSizeCategoryExtraExtraExtraLarge},
                                       @{@"ExtraExtraLarge": UIContentSizeCategoryExtraExtraLarge},
                                       @{@"ExtraLarge": UIContentSizeCategoryExtraLarge},
                                       @{@"Large": UIContentSizeCategoryLarge},
                                       @{@"Medium": UIContentSizeCategoryMedium},
                                       @{@"Small": UIContentSizeCategorySmall},
                                       @{@"ExtraSmall": UIContentSizeCategoryExtraSmall}];
    
    NSArray *textStyles = @[@{@"LargeTitle": @(PPUIFontTextStyleLargeTitle)},
                            @{@"Title1": @(PPUIFontTextStyleTitle1)},
                            @{@"Title2": @(PPUIFontTextStyleTitle2)},
                            @{@"Title3": @(PPUIFontTextStyleTitle3)},
                            @{@"Callout": @(PPUIFontTextStyleCallout)},
                            @{@"Headline": @(PPUIFontTextStyleHeadline)},
                            @{@"Subheadline": @(PPUIFontTextStyleSubheadline)},
                            @{@"Body": @(PPUIFontTextStyleBody)},
                            @{@"Footnote": @(PPUIFontTextStyleFootnote)},
                            @{@"Caption1": @(PPUIFontTextStyleCaption1)},
                            @{@"Caption2": @(PPUIFontTextStyleCaption2)}];
    
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    
    for (NSDictionary *fontDict in fonts) {
        l.font = fontDict.allValues.firstObject;
        NSLog(@"%@: %@", fontDict.allKeys.firstObject, l.font);
        
        if (@available(iOS 11.0, *)) {
            for (NSDictionary *styleDict in textStyles) {
                l.font = [PPUIFont preferredFontForTextStyle:(PPUIFontTextStyle)((NSNumber *)styleDict.allValues.firstObject).integerValue font:fontDict.allValues.firstObject];
                NSLog(@"%@.%@: %@", fontDict.allKeys.firstObject, styleDict.allKeys.firstObject, l.font);
            }
        }
        
        for (NSDictionary *styleDict in textStyles) {
            for (NSDictionary *categoryDict in contentSizeCategories) {
                UIFontTextStyle textStyle = [PPUIFont identifierForTextStyle:(PPUIFontTextStyle)((NSNumber *)styleDict.allValues.firstObject).integerValue];
                UIFontDescriptor *fontDescriptor = [PPUIFont preferredFontDescriptorWithTextStyle:textStyle fontName:((UIFont *)fontDict.allValues.firstObject).fontName contentSizeCategory:categoryDict.allValues.firstObject];
                l.font = [UIFont fontWithDescriptor:fontDescriptor size:fontDescriptor.pointSize];
                NSLog(@"%@.%@.%@: %@", fontDict.allKeys.firstObject, styleDict.allKeys.firstObject, categoryDict.allKeys.firstObject, l.font);
            }
        }
    }
}

- (void)testAllFontIcons {
    for (NSString *typeName in [PPUIFont fontIconTypeNames]) {
        NSData *glyphData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@-glyphs", typeName] ofType:@"json"]];
        
        NSError *error;
        NSDictionary *glyphs = [NSJSONSerialization JSONObjectWithData:glyphData options:0 error:&error];
        XCTAssertNil(error);
        for(NSString *key in glyphs.allKeys) {
            UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
            l.font = [PPUIFont fontIconWithSize:10 type:[PPUIFont fontTypeForMappingFontTypeName:typeName]];
            NSString *unicodeCharStringEscaped = [NSString stringWithFormat:@"\\u%@", [glyphs objectForKey:key]];
            const char *unicodeChar = [unicodeCharStringEscaped cStringUsingEncoding:NSUTF8StringEncoding];
            l.text = [NSString stringWithCString:unicodeChar encoding:NSNonLossyASCIIStringEncoding];
            
            NSLog(@"Icon-%@: %@ (%@)", typeName, key, l.text);
        }
    }
}

- (void)testFontIconsIOTIcons {
    NSData *glyphData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:kGlyphFilenamePPCIOTIcons ofType:@"json"]];
    
    NSError *error;
    NSDictionary *glyphs = [NSJSONSerialization JSONObjectWithData:glyphData options:0 error:&error];
    XCTAssertNil(error);
    for(NSString *key in glyphs.allKeys) {
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        l.font = [PPUIFont fontIconWithSize:10 type:PPFontIconTypePP];
        NSString *unicodeCharStringEscaped = [NSString stringWithFormat:@"\\u%@", [glyphs objectForKey:key]];
        const char *unicodeChar = [unicodeCharStringEscaped cStringUsingEncoding:NSUTF8StringEncoding];
        l.text = [NSString stringWithCString:unicodeChar encoding:NSNonLossyASCIIStringEncoding];
        
        NSLog(@"IOTIcon: %@ (%@)", key, l.text);
    }
}

- (void)testFontIconsWeatherIcons {
    NSData *glyphData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:kGlyphFilenameWeatherIcons ofType:@"json"]];
    
    NSError *error;
    NSDictionary *glyphs = [NSJSONSerialization JSONObjectWithData:glyphData options:0 error:&error];
    XCTAssertNil(error);
    for(NSString *key in glyphs.allKeys) {
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        l.font = [PPUIFont fontIconWithSize:10 type:PPFontIconTypeWeather];
        NSString *unicodeCharStringEscaped = [NSString stringWithFormat:@"\\u%@", [glyphs objectForKey:key]];
        const char *unicodeChar = [unicodeCharStringEscaped cStringUsingEncoding:NSUTF8StringEncoding];
        l.text = [NSString stringWithCString:unicodeChar encoding:NSNonLossyASCIIStringEncoding];
        
        NSLog(@"WeatherIcon: %@ (%@)", key, l.text);
    }
}

- (void)testFontIconsFontAwesome {
    NSData *glyphData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:kGlyphFilenameFontAwesome ofType:@"json"]];
    
    NSError *error;
    NSDictionary *glyphs = [NSJSONSerialization JSONObjectWithData:glyphData options:0 error:&error];
    XCTAssertNil(error);
    for(NSString *key in glyphs.allKeys) {
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        l.font = [PPUIFont fontIconWithSize:10 type:PPFontIconTypeFA];
        NSString *unicodeCharStringEscaped = [NSString stringWithFormat:@"\\u%@", [glyphs objectForKey:key]];
        const char *unicodeChar = [unicodeCharStringEscaped cStringUsingEncoding:NSUTF8StringEncoding];
        l.text = [NSString stringWithCString:unicodeChar encoding:NSNonLossyASCIIStringEncoding];
        
        NSLog(@"FontAwesome: %@ (%@)", key, l.text);
    }
}

- (void)testFontIconsFontAwesomeBrands {
    NSData *glyphData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:kGlyphFilenameFontAwesomeBrands ofType:@"json"]];
    
    NSError *error;
    NSDictionary *glyphs = [NSJSONSerialization JSONObjectWithData:glyphData options:0 error:&error];
    XCTAssertNil(error);
    for(NSString *key in glyphs.allKeys) {
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        l.font = [PPUIFont fontIconWithSize:10 type:PPFontIconTypeFABrands];
        NSString *unicodeCharStringEscaped = [NSString stringWithFormat:@"\\u%@", [glyphs objectForKey:key]];
        const char *unicodeChar = [unicodeCharStringEscaped cStringUsingEncoding:NSUTF8StringEncoding];
        l.text = [NSString stringWithCString:unicodeChar encoding:NSNonLossyASCIIStringEncoding];
        
        NSLog(@"FontAwesomeBrands: %@ (%@)", key, l.text);
    }
}
*/
@end
