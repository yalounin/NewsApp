//
//  SortFunctions.swift
//  NewsApp
//
//  Created by Max Yalounin on 30.07.2020.
//  Copyright © 2020 Max Yalounin. All rights reserved.
//

import Foundation


class SortFunctions {
    // сортировка По времени (asc)
    func dateAscSortTable() {
        self.sortedButtonOutlet.setTitle("По времени (asc)", for: .normal)
        let sortedNews = news
        self.news = sortedNews.sorted() {
            $0.dateValue.compare($1.dateValue) == .orderedAscending
        }
        tableView.reloadData()
    }
    
    // сортировка По времени (desc)
    func dateDescSortTable() {
        self.sortedButtonOutlet.setTitle("По времени (desc)", for: .normal)
        let sortedNews = news
        self.news = sortedNews.sorted() {
            $0.dateValue.compare($1.dateValue) == .orderedDescending
        }
        tableView.reloadData()
    }
    
    // сортировка По длине текста (asc)
    func lengthAscSortTable() {
        self.sortedButtonOutlet.setTitle("По длине текста (asc)", for: .normal)
        let sortedNews = news
        self.news = sortedNews.sorted() {
            $0.text.count < $1.text.count
        }
        tableView.reloadData()
    }
    
    // сортировка По длине текста (desc)
    func lengthDescSortTable() {
        self.sortedButtonOutlet.setTitle("По длине текста (desc)", for: .normal)
        let sortedNews = news
        self.news = sortedNews.sorted() {
            $0.text.count > $1.text.count
        }
        tableView.reloadData()
    }
    
    // сбросить сортировку - восстановить исходный порядок с помощью копии
    func resetSortTable() {
        self.sortedButtonOutlet.setTitle("Нет сортировки", for: .normal)
        self.news = self.doubleNews
        tableView.reloadData()
    }
}
