/*
 This source file is part of the Swift.org open source project

 Copyright 2015 - 2016 Apple Inc. and the Swift project authors
 Licensed under Apache License v2.0 with Runtime Library Exception

 See http://swift.org/LICENSE.txt for license information
 See http://swift.org/CONTRIBUTORS.txt for Swift project authors
*/

import PackageModel
import Multitool
import Utility
import Build
import POSIX

#if os(Linux)
public func describe(_ prefix: String, _ conf: Configuration, _ modules: [Module], _ externalModules: Set<Module>, _ products: [Product], Xcc: [String], Xld: [String], Xswiftc: [String], toolchain: Toolchain) throws -> String {
    do {
        return try Build.describe(prefix, conf, modules, externalModules, products, Xcc: Xcc, Xld: Xld, Xswiftc: Xswiftc, toolchain: toolchain)
    } catch {

        // it is a common error on Linux for clang++ to not be installed, but
        // we need it for linking. swiftc itself gives a non-useful error, so
        // we try to help here.
        
        //FIXME we should use C-functions here

        if (try? Utility.popen(["command", "-v", "clang++"])) == nil {
            print("warning: clang++ not found: this will cause build failure", to: &stderr)
        }

        throw error
    }
}
#endif
