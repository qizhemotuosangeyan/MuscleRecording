//
//  Persistence.swift
//  MuscleRecording
//
//  Created by 千千 on 6/22/24.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        // 设置一些示例数据
        let acromion = UserBody(context: viewContext)
        acromion.timeStamp = Date()
        acromion.part = BodyPart.DeltoidPart.Acromion.title
        acromion.value = 150
        
        let pectoral = UserBody(context: viewContext)
        pectoral.timeStamp = Date()
        pectoral.part = BodyPart.ChestPart.Pectoral.title
        pectoral.value = 84
        
        let bicepsPeak = UserBody(context: viewContext)
        bicepsPeak.timeStamp = Date()
        bicepsPeak.part = BodyPart.ArmPart.BicepsPeak.title
        bicepsPeak.value = 45
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "MuscleRecording")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            print("sqlite store at: \(storeDescription)")
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
