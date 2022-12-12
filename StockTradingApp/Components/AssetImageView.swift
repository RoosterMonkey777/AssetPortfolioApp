// Group# 12
// Zahaak Khan : 991625231
// Shareef Aldahhan : 991598634

// worked on by Shareef

// geting image from data

import SwiftUI

struct AssetImageView : View {
    let urlString : String
    @State var data : Data?
    
    
    var body : some View{
        if let data = data, let image = UIImage(data:data){
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                #if os(watchOS)
                .frame(width: 25, height: 25)
                #else
                .frame(width: 50, height: 50)
                #endif
                .scaledToFit()
                .onAppear{
                    fetchImageData()
                }
                
        } else {
            ProgressView()
                .onAppear{
                    fetchImageData()
                }
        }
    }
    
    func fetchImageData() {
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url){ data, _,_ in
            DispatchQueue.main.async {
                self.data = data

            }
        }
        task.resume()
    }
    
}



//struct AssetImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        AssetImageView(urlString: nil)
//    }
//}
