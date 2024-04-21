import SwiftUI

struct CommunityView: View {
    @State private var searchText = ""
    @State private var isCreatingNewDiscussion = false
    @State var text: String = ""
    @StateObject var postVM: PostViewModel = PostViewModel()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom){
                VStack {
                    
                    Text("Community👥")
                        .font(Font.custom("Poppins", size: 22).weight(.semibold))
                        .foregroundColor(.black)
                        .offset(x: -100, y: 10)
                    
                    HStack(spacing: 16) {
                        Text("Follow QuickSkill:")
                            .font(Font.custom("Poppins", size: 14))
                        
                        HStack(alignment: .center, spacing: 10) {
                            
                            Button(action: openDiscord) {
                                Image("Discord Icon")
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(width: 34.40, height: 34.40)
                                    .background(Circle()
                                        .fill(Color("Purple")))
                            }
                            
                            Button(action: openDeveloperTelegram) {
                                Image("Telegram Icon")
                                    .resizable()
                                    .frame(width: 22, height: 20)
                                    .padding()
                                    .frame(width: 32.5, height: 32.5)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color("Purple"), lineWidth: 1))
                            }
                        }
                        
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 6, leading: 20, bottom: 18, trailing: 0))
                    
                    VStack(alignment: .leading, spacing: 16) {
                        
                        HStack {
                            
                            Button(action: {
                                
                            }, label: {
                                Image("Lupa")
                                    .resizable()
                                    .frame(width: 21, height: 21)
                            })
                            
                            TextField("Search question", text: $text)
                        }
                        .padding(EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 9))
                        .frame(width: 354, height: 39)
                        .background(Color(red: 0.91, green: 0.91, blue: 0.92))
                        .cornerRadius(15)
                        
                        HStack {
                            
                            HStack(alignment: .top, spacing: 4) {
                                HStack(spacing: 4) {
                                    Text("Popular")
                                        .font(Font.custom("Poppins", size: 12))
                                        .foregroundColor(.white)
                                    
                                    Image(systemName: "chevron.down")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundStyle(.white)
                                        .frame(width: 12, height: 12)
                                }
                                .padding(EdgeInsets(top: 4, leading: 12, bottom: 4, trailing: 12))
                                .background(Color("Purple"))
                                .cornerRadius(15)
                            }
                            
                            Spacer()
                            
                            Text("\(postVM.posts.count) discussions")
                                .font(Font.custom("Poppins", size: 12))
                                .foregroundColor(.black)
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 6, trailing: 20))
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        // Section for discussions
                        VStack(spacing: 18) {
                            ForEach($postVM.posts, id: \.discussion.id) { $post in
                                DiscussionCell(post: post)
                            }
                            .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                        }
                        
                    }
                    .refreshable {
                        postVM.getPosts()
                    }
                    
                    // New Discussion Button
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.4)) {
                            self.isCreatingNewDiscussion = true
                        }
                    }) {
                        ZStack() {
                            
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 150, height: 45)
                                .background(Color("Purple"))
                                .cornerRadius(16.52)
                            
                            HStack {
                                Image(systemName: "plus")
                                Text("New discuss")
                            }
                            .font(Font.Poppins(size: 15.73))
                            .foregroundColor(.white)
                        }
                    }
                }
                .blur(radius: isCreatingNewDiscussion ? 5 : 0)
                
                if isCreatingNewDiscussion {
                    GeometryReader { geometry in
                        VStack {
                            
                            Spacer()
                            
                            HStack {
                                Spacer()
                                
                                NewPostView(isPresented: $isCreatingNewDiscussion, postVM: postVM)
                                    .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.95)
                                    .background(Color.white)
                                    .cornerRadius(20)
                                    .shadow(radius: 5)
                                
                                Spacer()
                            }
                        }
                        
                    }
                    .background(
                        Color.white.opacity(0.1)
                            .edgesIgnoringSafeArea(.all)
                            .onTapGesture {
                                isCreatingNewDiscussion = false
                            }
                    )
                }
            }
        }
        .onAppear() {
            postVM.getPosts()
        }
    }
    
    func openDeveloperTelegram() {
        let telegramUsername = "EvgeniyB2077"
        let appURL = URL(string: "tg://resolve?domain=\(telegramUsername)")!
        let webURL = URL(string: "https://t.me/\(telegramUsername)")!
        
        if UIApplication.shared.canOpenURL(appURL) {
            UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.open(webURL, options: [:], completionHandler: nil)
        }
    }
    
    func openDiscord() {
        let discordInviteLink = "https://discord.gg/schDm8je"
        guard let url = URL(string: discordInviteLink) else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}

struct DiscussionCell: View {
    @State var post: Post
    
    var body: some View {
        NavigationLink(destination: PostView(post: $post)) {
            VStack(alignment: .leading, spacing: 12) {
                
                HStack {
                    VStack(alignment: .leading, spacing: 14) {
                        Text(post.discussion.title)
                            .font(Font.custom("Poppins", size: 13))
                        
                        HStack(alignment: .top, spacing: 19.36) {
                            HStack(spacing: 19.36) {
                                HStack(spacing: 4.84) {
                                    Image("Like")
                                        .resizable()
                                        .frame(width: 17, height: 17)
                                    
                                    Text("\(post.discussion.likes)")
                                        .font(Font.custom("Poppins", size: 9.68))
                                }
                                .frame(width: 37.20, height: 21.78)
                                
                                HStack(spacing: 4.84) {
                                    Image("Comments_2")
                                    
                                    
                                    Text("\(post.discussion.answersCount)")
                                        .font(Font.custom("Poppins", size: 9.68))
                                }
                                .frame(width: 36.20, height: 21.78)
                                
                                Text(post.discussion.publishedOn.prefix(10))
                                    .font(Font.custom("Poppins", size: 9.68))
                            }
                        }
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 10) {
                        if let photo = post.author.photo {
                            AsyncImage(url: URL(string: photo)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 34, height: 34)
                            .clipShape(Circle())
                        } else {
                            Image(systemName: "person.circle")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 34, height: 34)
                                .clipShape(Circle())
                        }
                        
                        Text(post.author.fullName)
                            .font(Font.custom("Poppins", size: 9.68))
                    }
                }
            }
            .foregroundColor(.black)
            .padding(20)
            .background(Color.white)
            .cornerRadius(18.15)
            .shadow(
                color: Color(red: 0, green: 0, blue: 0, opacity: 0.17), radius: 4.84, y: 4.84
            )
        }
    }
}

#Preview {
    CommunityView()
}
