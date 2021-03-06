
import Foundation
import CoreData

class ActionsManager {
    
    static let shared = ActionsManager()
    private static var config: Config!

    struct Config {
        let context: NSManagedObjectContext
    }

    class func setup(_ config: Config) {
        ActionsManager.config = config
    }

    private init() {
        guard ActionsManager.config != nil else {
            fatalError("Error - you must call setup before accessing ActionsManager.shared")
        }
    }
    
    func saveAction(for id: Int, action: Int = 0, seen: Bool) {
        let context = ActionsManager.config.context
        if let object = NSEntityDescription.insertNewObject(forEntityName: "Action", into: context) as? Action {

            object.id = Int64(id)
            object.action = Int64(action)
            object.seen = seen
            
            do {
                try context.save()
            } catch {
                print("Failed to save action for id: \(id)")
            }
        }
    }
    
    func retrieveAction(for id: Int) -> Action? {
        let context = ActionsManager.config.context
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Action")
        request.predicate = NSPredicate(format: "id = %d", id)

        do {
            let result = try context.fetch(request) as? [Action]
            return result?.first
        } catch {
            print("Failed to retrieve action for id: \(id)")
        }
        
        return nil
    }
    
    var dataBaseSize: String? {
        do {
            guard let storeUrl = ActionsManager.config.context.persistentStoreCoordinator?.persistentStores.first?.url else {
                return nil
            }
            
            let size = try Data(contentsOf: storeUrl)
            if size.count < 1 {
                return nil
            }
            let bcf = ByteCountFormatter()
            bcf.countStyle = .file
            let string = bcf.string(fromByteCount: Int64(size.count))
            print(string)
            return string
        } catch {
            return nil
        }
    }
}
