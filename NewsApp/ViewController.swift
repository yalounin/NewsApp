//
//  ViewController.swift
//  NewsApp
//
//  Created by Max Yalounin on 13.07.2020.
//  Copyright © 2020 Max Yalounin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var sortedButtonOutlet: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    // основная таблица данных
    var news = NewsList.allNews
    
    // копия таблицы для возможности отката
    var doubleNews: [News] = []
    
    // индекс развернутой ячейки (может не иметь значения)
    var indexOfExpandedCell: Int?
    
    @IBAction func sortButton(_ sender: UIButton) {
        
        // MARK: ДИАЛОГОВОЕ ОКНО
        let ac = UIAlertController(title: nil, message: "Сортировать", preferredStyle: .actionSheet)
        
        //  сортировки
        let sortDateAscAction = UIAlertAction(title: "По времени (asc)", style: .default) { [weak self] (action: UIAlertAction) ->Void  in
            self?.dateAscSortTable()
            self?.hideAllRowsText()
        }
        
        
        let sortDateDescAction = UIAlertAction(title: "По времени (desc)", style: .default) { [weak self] (action: UIAlertAction) ->Void in
            self?.dateDescSortTable()
            self?.hideAllRowsText()
        }
        
        
        let sortAscLengthTextAction = UIAlertAction(title: "По длине текста (asc)", style: .default) { [weak self] (action) in
            self?.lengthAscSortTable()
            self?.hideAllRowsText()
        }
        
        
        let sortDescLengthTextAction = UIAlertAction(title: "По длине текста (desc)", style: .default) { [weak self] (action) in
            self?.lengthDescSortTable()
            self?.hideAllRowsText()
        }
        
        
        let resetTextAction = UIAlertAction(title: "Сбросить", style: .default) { [weak self] (action) in
            self?.resetSortTable()
            self?.hideAllRowsText()
        }
        
        let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        ac.addAction(sortDateAscAction)
        ac.addAction(sortDateDescAction)
        ac.addAction(sortAscLengthTextAction)
        ac.addAction(sortDescLengthTextAction)
        ac.addAction(resetTextAction)
        ac.addAction(cancel)
        
        if let presenter = ac.popoverPresentationController {
            presenter.sourceView = sender;
        }
        
        present(ac, animated: true, completion: nil)
        
    }
    
    // количество секций
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // количество строк
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    
    // MARK: ФУНКЦИИ СОРТИРОВКИ
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
    
    // MARK: ИНИЦИАЛИЗАЦИЯ СТРОК
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsTableViewCell
        
        
        // наполнение строк данными
        cell.thumbnailImageView.image = UIImage(named: news[indexPath.row].image)
        cell.newsTextLabel.text = news[indexPath.row].text
        cell.dateLabel.text  = news[indexPath.row].date
        
        // сворачивание/разворачивание строк:
        
        if indexPath.row == indexOfExpandedCell {
            
            cell.newsTextLabel.numberOfLines = 0
            cell.changeLabelSizeButton.setTitle("Read less", for: .normal)
            
        } else {
            
            cell.newsTextLabel.numberOfLines = 3
            cell.changeLabelSizeButton.setTitle("Read more", for: .normal)
            
        }
        
        // присваеваем кастомному индексу кнопки порядковый номер строки
        cell.changeLabelSizeButton.indexOfCell = indexPath.row
        
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // загрузка view
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // установка автоматической высоты строки в зав-ти от контента
        self.tableView.estimatedRowHeight = 120
        self.tableView.rowHeight = UITableView.automaticDimension
        
        // дефолтный тайтл кнопки сортировки
        sortedButtonOutlet.setTitle("Нет сортировки", for: .normal)
        
        // наполнение копии данными
        doubleNews = news
        
        
    }
    
    
    // MARK: КНОПКА Read more/less
    @IBAction func changeLabelSize(_ sender: UICellButton) {
        
        self.tableView.beginUpdates()
        
        // определение, в какой строке происходит нажатие
        let selectedRow = sender.indexOfCell
        // присвоение индекса развернутой строки константе, так как далее он затирается
        let indexOfExpandedRow = indexOfExpandedCell
        
        // сворачиваем все строки таблицы
        hideAllRowsText()
        
        // разворачиваем выбранную строку, если она не развернута
        if indexOfExpandedRow != selectedRow {
            
            showFullText(param: selectedRow)
            
        }
        
        self.tableView.endUpdates()
        
    }
    
    
    // показать весь текст в выбранной строке
    func showFullText(param: Int) {
        indexOfExpandedCell = param
        let indexPath = IndexPath(row: param, section: 0)
        let cell = self.tableView.cellForRow(at: indexPath) as? NewsTableViewCell
        cell?.changeLabelSizeButton.setTitle("Read less", for: .normal)
        cell?.newsTextLabel.numberOfLines = 0
    }
    
    // скрыть текст во всех строках до дефолтного ограничения по строкам лейбла
    func hideAllRowsText() {
        indexOfExpandedCell = nil
        for i in 0..<news.count {
            let indexPath = IndexPath(row: i, section: 0)
            let cell = self.tableView.cellForRow(at: indexPath) as? NewsTableViewCell
            cell?.changeLabelSizeButton.setTitle("Read more", for: .normal)
            cell?.newsTextLabel.numberOfLines = 3
        }
    }
    
    
}


