//
//  MainView.swift
//  Journali
//
//  Created by alya Alabdulrahim on 04/05/1447 AH.
//
import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = JournalViewModel()

    var body: some View {
        ZStack {
            // Background
            LinearGradient(colors: [Color(red: 0.08, green: 0.08, blue: 0.08), .black],
                           startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 16) {
                header
                content
            }

            toolbar
            searchBar
        }
        .sheet(isPresented: $viewModel.isPresentingNewEntry) {
            NewEntrySheet(
                title: $viewModel.newTitle,
                content: $viewModel.newContent,
                onCancel: viewModel.resetForm,
                onSave: viewModel.saveNewEntry
            )
        }
    }

    // MARK: - Subviews
    private var header: some View {
        HStack {
            Text("Journal")
                .font(.system(size: 34, weight: .bold))
                .foregroundStyle(.white)
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
    }

    private var content: some View {
        Group {
            if viewModel.filteredAndSortedItems.isEmpty {
                VStack(spacing: 12) {
                    Image("openBook")
                    Text("Begin Your Journal")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(Color("Purple"))
                        .offset(y: -80)
                    Text("Craft your personal diary, tap the plus icon to begin")
                        .font(.system(size: 18))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                        .offset(y: -75)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.filteredAndSortedItems) { item in
                            SwipeableCard(onDelete: {
                                viewModel.deleteItem(id: item.id)
                            }) {
                                CardView(item: item) {
                                    viewModel.toggleBookmark(for: item.id)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 24)
                }
            }
        }
    }

    private var toolbar: some View {
        VStack {
            HStack {
                Spacer()
                HStack(spacing: 12) {
                    Button {
                        withAnimation { viewModel.isShowingFilterMenu.toggle() }
                    } label: {
                        Image("filter")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22, height: 22)
                            .padding(.vertical, 8)
                    }

                    Divider().background(Color.white.opacity(0.25)).frame(height: 20)

                    Button {
                        viewModel.isPresentingNewEntry = true
                    } label: {
                        Image("plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22, height: 22)
                            .padding(.vertical, 8)
                    }
                }
                .padding(.horizontal, 14)
                .frame(height: 44)
                .background(Capsule().fill(Color.white.opacity(0.04)))
                .overlay(Capsule().strokeBorder(Color.white.opacity(0.18)))
                .shadow(color: .black.opacity(0.35), radius: 10, x: 0, y: 8)
                .padding(.trailing, 16)
                .padding(.top, 16)
                .overlay(alignment: .topTrailing) {
                    if viewModel.isShowingFilterMenu {
                        FilterPanel(
                            currentMode: viewModel.sortMode,
                            currentFilter: viewModel.filterMode,
                            onSelectBookmarkOnly: {
                                viewModel.filterMode = .bookmarkedOnly
                                viewModel.sortMode = .bookmarkFirst
                                viewModel.isShowingFilterMenu = false
                            },
                            onSelectEntryDateAll: {
                                viewModel.filterMode = .all
                                viewModel.sortMode = .entryDateDesc
                                viewModel.isShowingFilterMenu = false
                            },
                            onDismissOutside: {
                                withAnimation {
                                    viewModel.isShowingFilterMenu = false
                                }
                            }
                        )
                        .offset(y: 54)
                        .transition(.move(edge: .top).combined(with: .opacity))
                    }
                }
            }
            Spacer()
        }
    }

    private var searchBar: some View {
        VStack {
            Spacer()
            HStack {
                HStack(spacing: 10) {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.white.opacity(0.9))
                    TextField("Search...", text: $viewModel.searchText)
                        .foregroundStyle(.white)
                    Image(systemName: "microphone")
                        .foregroundStyle(.white.opacity(0.9))
                }
                .padding(.horizontal, 16)
                .frame(height: 56)
                .background(RoundedRectangle(cornerRadius: 28).fill(Color.white.opacity(0.04)))
                .overlay(RoundedRectangle(cornerRadius: 28).strokeBorder(.white.opacity(0.5)))
                .shadow(color: .black.opacity(0.35), radius: 10, x: 0, y: 8)
                .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 20)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    MainView()
}
