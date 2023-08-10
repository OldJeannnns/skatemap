import SwiftUI
import WebKit

struct ContentView: View {
    @State var isSharePresented = false
    let texturl = "https://apps.apple.com/kr/app/skatemap/id6449299366"
    
    let webView = WebView(request: URLRequest(url: URL(string: "https://skatemap.kr")!))
    
    var body: some View {
        VStack {
            webView
            
            HStack(alignment: .top) {
                //MARK: - Back Button
                Button(action: {
                    self.webView.goBack()
                }){
                    Image(systemName:"arrow.uturn.left")
                        .font(.title)
                        .foregroundColor(.black)
                        .padding(.leading, 20)
                        .padding(.top, 10)
                }
                Spacer()
                
                //MARK: - Home Button
                Button(action: {
                    self.webView.goHome()
                }){
                    Image(systemName: "house")
                        .font(.title)
                        .foregroundColor(.black)
                        .padding(.top, 10)

                }
                Spacer()
                //MARK: - share Button
                
                Button {
                    self.isSharePresented = true
                } label: {
                    Image(systemName: "square.and.arrow.up")
                        .font(.title)
                        .foregroundColor(.black)
                        .padding(.top, 10)
                        .padding(.trailing, 20)
                }
                .sheet(
                    isPresented: $isSharePresented,
                    onDismiss: { print("Dismiss") },
                    content: { ActivityViewController(activityItems: [texturl]) }
                )
            }
            .frame(height: 50)
        }
    }
}

struct WebView: UIViewRepresentable {
    let request: URLRequest
    private var webView: WKWebView?
    
    init(request: URLRequest) {
        self.webView = WKWebView()
        self.request = request
    }
    
    func makeUIView(context: Context) -> WKWebView {
        return webView!
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
    
    func goBack(){
        webView?.goBack()
    }
    
    func goForward(){
        webView?.goForward()
    }
    
    func refresh() {
        webView?.reload()
    }
    
    func goHome() {
        webView?.load(request)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

