import SwiftUI
import FSCalendar
 
struct CalendarTestView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIView {
        
        typealias UIViewType = FSCalendar
        
        let fsCalendar = FSCalendar()
            
        return fsCalendar
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
}
 
