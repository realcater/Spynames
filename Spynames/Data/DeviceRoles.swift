enum DeviceRoles: CaseIterable {
    case redSpymaster
    case redOperatives
    case blueSpymaster
    case blueOperatives
    
    func next(devicesQty: Int) -> DeviceRoles? {
        let all = getAll(devicesQty: devicesQty)
        switch all.count {
            case 1: return self
            case 2...4: return all[1]
            default: return nil
        }
    }
    func getAll(devicesQty: Int) -> [DeviceRoles] {
        switch (devicesQty, self) {
        case (1, .redSpymaster): return [.redSpymaster, .redOperatives, .blueSpymaster, .blueOperatives]
        case (1, .redOperatives): return [.redOperatives, .blueSpymaster, .blueOperatives, .redSpymaster]
        case (1, .blueSpymaster): return [.blueSpymaster, .blueOperatives, .redSpymaster, .redOperatives]
        case (1, .blueOperatives): return [.blueOperatives, .redSpymaster, .redOperatives, .blueSpymaster]
            
        case (2, .redSpymaster): return [.redSpymaster, .blueSpymaster]
        case (2, .blueSpymaster): return [.blueSpymaster, .redSpymaster]
        case (2, .redOperatives): return [.redOperatives, .blueOperatives]
        case (2, .blueOperatives): return [.blueOperatives, .redOperatives]
        
        case (3, .redSpymaster): return [.redSpymaster]
        case (3, .blueSpymaster): return [.blueSpymaster]
        case (3, .redOperatives): return [.redOperatives, .blueOperatives]
        case (3, .blueOperatives): return [.blueOperatives, .redOperatives]
            
        case (4, _): return [self]
        default: return []
        }
    }
}
