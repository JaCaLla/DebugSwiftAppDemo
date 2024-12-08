//
//  ContentView.swift
//  DebugSwiftAppDemo
//
//  Created by Javier Calatrava on 6/12/24.
//
import SwiftUI
@MainActor
final class CharacterViewModel: ObservableObject {
    @Published var characters: [Character] = []
    
    func fetch() async {
        characters = []
        let result = await currentApp.dataManager.fetchCharacters(CharacterService())
        switch result {
        case .success(let characters):
            self.characters = characters
        case .failure(let error):
            print(error)
        }
    }
}


struct CharacterView: View {
    @ObservedObject var viewModel = CharacterViewModel()
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(viewModel.characters) { character in
                    NavigationLink {
                        DetailView(detailViewModel: DetailViewModel(character: character))
                    } label: {
                        HStack {
                            characterImageView(character.imageUrl)
                            Text("\(character.name)")
                            Spacer()
                        }
                    } 
                }
            }
        }
        .padding()
        .onAppear {
            Task {
                 await viewModel.fetch()
            }
        }
    }
    
    fileprivate func characterImageView(_ string: String) -> AsyncImage<_ConditionalContent<some View, some View>> {
        return AsyncImage(url: URL(string: string),
                          transaction:  .init(animation: .easeIn(duration: 0.2))) { phase in
            switch phase {
            case .success(let image):
                image .resizable() // Make the image resizable
                    .aspectRatio(contentMode: .fit) // Set the aspect ratio to fill
                    .frame(width: 100, height: 100) // Set the frame size
                    .clipped()
                
            default:
                Image(systemName: "checkmark.rectangle")
                    .clipped()
                    .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    CharacterView()
}
