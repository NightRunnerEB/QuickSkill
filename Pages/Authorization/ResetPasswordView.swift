import SwiftUI

struct ResetPasswordView: View {
    @EnvironmentObject var userVM: UserViewModel
    @FocusState private var focusedField: Field?
    @State private var confirmPassword = ""
    
    enum Field {
        case password
        case confirmPassword
    }
    
    var body: some View {
        Text("Hello")
//        VStack {
//            Spacer()
//            VStack(spacing: 10) {
//                VStack(spacing: 8) {
//                    Text("🔐")
//                    Text("Reset password")
//                        .font(Font.custom("Poppins", size: 17).weight(.medium))
//                        .foregroundColor(.black)
//                    Text("Forgot your password? No problem. \nEnter your registered email: ")
//                        .multilineTextAlignment(.center)
//                        .font(Font.custom("Poppins", size: 14).weight(.light))
//                        .foregroundColor(.black)
//                }
//            }
//            .padding(16)
//            .frame(width: 308, height: 128)
//            .background(Color("Block"))
//            .cornerRadius(24)
//            .padding(.bottom, 70)
//            
//            if viewModel.isEmailValid {
//                VStack {
//                    HStack() {
//                        SecureField("Password", text: $viewModel.newPassword)
//                            .focused($focusedField, equals: .password)
//                            .submitLabel(.next)
//                            .onSubmit { focusedField = .confirmPassword }
//                            .font(Font.custom("Poppins", size: 17))
//                        
//                        Button(action: {
//                            viewModel.newPassword = ""
//                        }, label: {
//                            Image(systemName: "xmark.circle.fill")
//                                .imageScale(.small)
//                                .foregroundStyle(Color.gray)
//                        })
//                    }
//                    .padding(.horizontal, 17)
//                    Rectangle()
//                        .foregroundColor(.clear)
//                        .frame(width: 365, height: 0.7)
//                        .background(Color(red: 0.78, green: 0.78, blue: 0.78))
//                        .padding(.bottom, 35)
//                }
//                
//                VStack {
//                    HStack() {
//                        SecureField("Confirm password", text: $confirmPassword)
//                            .focused($focusedField, equals: .confirmPassword)
//                            .submitLabel(.done)
//                            .font(Font.custom("Poppins", size: 17))
//                            .padding(.top, 30)
//                        
//                        Button(action: {
//                            confirmPassword = ""
//                        }, label: {
//                            Image(systemName: "xmark.circle.fill")
//                                .imageScale(.small)
//                                .foregroundStyle(Color.gray)
//                        })
//                    }
//                    .padding(.horizontal, 17)
//                    Rectangle()
//                        .foregroundColor(.clear)
//                        .frame(width: 365, height: 0.7)
//                        .background(Color(red: 0.78, green: 0.78, blue: 0.78))
//                }
//                
//                Spacer()
//                
//                Button(action: {
////                viewModel.resetPassword() Временно! Для тестирования UI! Очень нужная строка!
//                 userVM.isPasswordUpdated = true
//                }, label: {
//                    HStack(spacing: 10) {
//                        Text("Reset password")
//                            .font(Font.custom("Poppins", size: 17).weight(.medium))
//                            .foregroundColor(.white)
//                    }
//                    .padding(EdgeInsets(top: 15, leading: 33, bottom: 15, trailing: 33))
//                    .frame(width: 202, height: 56)
//                    .background(viewModel.email.isEmpty ? Color.gray : Color(red: 0.41, green: 0.05, blue: 0.92))
//                    .cornerRadius(24)
//                })
//                .disabled(viewModel.email.isEmpty)
//                
//            } else {
//                VStack {
//                    HStack() {
//                        TextField("Email", text: $viewModel.email)
//                            .autocapitalization(.none)
//                            .keyboardType(.emailAddress)
//                            .submitLabel(.join)
//                            .font(Font.custom("Poppins", size: 17))
//                            .padding(.top, 30)
//                        
//                        Button(action: {
//                            viewModel.email = ""
//                        }, label: {
//                            Image(systemName: "xmark.circle.fill")
//                                .imageScale(.small)
//                                .foregroundStyle(Color.gray)
//                        })
//                    }
//                    Rectangle()
//                        .foregroundColor(.clear)
//                        .frame(width: 365, height: 0.7)
//                        .background(Color(red: 0.78, green: 0.78, blue: 0.78))
//                        .padding(.bottom, 35)
//                }
//                
//                Spacer()
//                
//                Button(action: {
////                viewModel.verifyEmail() Временно! Для тестирования UI! Очень нужная строка!
//                    viewModel.isEmailValid = true
//                }, label: {
//                    HStack(spacing: 10) {
//                        Text("Verify Email")
//                            .font(Font.custom("Poppins", size: 17).weight(.medium))
//                            .foregroundColor(.white)
//                    }
//                    .padding(EdgeInsets(top: 15, leading: 33, bottom: 15, trailing: 33))
//                    .frame(width: 202, height: 56)
//                    .background(viewModel.email.isEmpty ? Color.gray : Color(red: 0.41, green: 0.05, blue: 0.92))
//                    .cornerRadius(24)
//                })
//                .disabled(viewModel.email.isEmpty)
//            }
//            
//            if viewModel.isLoading {
//                ProgressView()
//            }
//            
//            if let errorMessage = viewModel.errorMessage {
//                Text(errorMessage)
//                    .foregroundColor(.red)
//                    .padding()
//            }
//            
//        }
//        .padding()
//        .alert("Success", isPresented: $viewModel.isPasswordUpdated) {
//            Button("OK", role: .cancel) { }
//        } message: {
//            Text("Your password has been successfully reset.")
//        }
    }
}

#Preview {
    ResetPasswordView()
}



