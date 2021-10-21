//
//  PodcastDetailView.swift
//  El Meneo
//
//  Created by Giomar Rodriguez on 10/19/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct PodcastDetailView: View {
    @StateObject var viewModel = PodcastDetailViewModel()
    @State var podcast: Podcast
    var body: some View {
        VStack {
            
            WebImage(url: podcast.imageOriginalURL)
                .resizable()
                .frame(height: 200)
                .clipped()
            
            
            List {
                ForEach(viewModel.episodes, id:\.episodeID) { episode in
                    HStack {
                        Text(episode.title)
                        Spacer()
                        Text("\(episode.getDuration())")
                            .foregroundColor(Color.gray)
                    }
                }
            }.listStyle(.plain)
            
        }
        .onAppear {
            self.podcast = SamplePodcasts.shared.fetchPodcast()
            viewModel.fetchEpisodes(showId: podcast.showID)
        }
    }
}

struct PodcastDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PodcastDetailView(podcast: SamplePodcasts.shared.fetchPodcast())
    }
}
