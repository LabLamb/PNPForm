//
//  Copyright © LabLambWorks. All rights reserved.
//

public typealias RowValue = String?
public typealias ValidationLogic = (RowValue) -> (Bool)
public typealias ValidatedHandler = (BaseRow, Bool) -> Void
