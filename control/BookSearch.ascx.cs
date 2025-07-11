﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json.Linq;
using System.Net;
using System.IO;
using Rockying.Models;
using Newtonsoft.Json;
using Rockying;

public partial class control_BookSearch : System.Web.UI.UserControl
{
    public Member CurrentUser { get; set; }
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void SearchButton_Click(object sender, EventArgs e)
    {
        List<Book> books = new List<Book>();
        using (WebClient client = new WebClient())
        {
            // Add a user agent header in case the
            // requested URI contains a query.

            client.Headers.Add("user-agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.2; .NET CLR 1.0.3705;)");

            Stream data = client.OpenRead("https://www.googleapis.com/books/v1/volumes?q=" + SearchKeywordTextBox.Text.Trim() + "&key=AIzaSyAKozbZaW6JSBL3FeymL8Fv6mMUxvR_H5M");
            StreamReader reader = new StreamReader(data);
            string s = reader.ReadToEnd();
            data.Close();
            reader.Close();
            dynamic result = JObject.Parse(s);
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
            {
                books.AddRange(dc.Books.Where(t => t.Title.Contains(SearchKeywordTextBox.Text) || t.ISBN13.Contains(SearchKeywordTextBox.Text) || t.ISBN10.Contains(SearchKeywordTextBox.Text) || t.Author.Contains(SearchKeywordTextBox.Text)).Distinct().ToList());
                if (result.items != null)
                {
                   foreach (var item in result.items)
                   {
                       if (item.volumeInfo != null)
                       {
                           var vi = item.volumeInfo;
                           Book b = new Book()
                           {
                               Title = string.Empty,
                               Identifiers = string.Empty,
                               Author = string.Empty,
                               GoogleData = string.Empty,
                               Description = string.Empty,
                               Categories = string.Empty,
                               CoverPage = string.Empty,
                               ISBN10 = string.Empty,
                               ISBN13 = string.Empty,
                               PageCount = 0,
                               PublishDate = string.Empty,
                               Publisher = string.Empty,
                               CreateDate = DateTime.Now
                           };
                           if (vi.title != null)
                               b.Title = vi.title;
                           if (vi.imageLinks != null)
                               if (vi.imageLinks.thumbnail != null)
                                   b.CoverPage = vi.imageLinks.thumbnail;
                           if (vi.authors != null)
                               foreach (var a in vi.authors)
                                   b.Author = a + ", " + b.Author;
                           b.Author = b.Author.Trim(", ".ToCharArray());
                           if (vi.categories != null)
                               foreach (var a in vi.categories)
                                   b.Categories = a + ", " + b.Categories;
                           b.Categories = b.Categories.Trim(", ".ToCharArray());
                           if (vi.description != null)
                               b.Description = vi.description;
                           b.GoogleData = JsonConvert.SerializeObject(item);
                           if (vi.industryIdentifiers != null)
                               foreach (var ii in vi.industryIdentifiers)
                                   if (ii.type == "ISBN_13")
                                       b.ISBN13 = ii.identifier;
                                   else if (ii.type == "ISBN_10")
                                       b.ISBN10 = ii.identifier;
                                   else
                                       b.Identifiers = ii.identifier + ", " + b.Identifiers;
                           b.Identifiers = b.Identifiers.Trim(", ".ToCharArray());
                           if (vi.pageCount != null)
                               b.PageCount = vi.pageCount;
                           if (vi.publishedDate != null)
                               b.PublishDate = vi.publishedDate;
                           if (vi.publisher != null)
                               b.Publisher = vi.publisher;
                           b = SanitizeBookData(b);
                           var bkfromdb = dc.Books.FirstOrDefault(t => t.Title == b.Title || t.ISBN10 == b.ISBN10 || t.ISBN13 == b.ISBN13);
                           if (bkfromdb == null)
                           {
                               dc.Books.InsertOnSubmit(b);
                               books.Add(b);
                           }
                           else
                               books.Add(bkfromdb);
                       }
                   }
                   dc.SubmitChanges();
                }
                var list = books.Distinct().ToList();
                SearchResultRepeater.DataSource = list;
                SearchResultRepeater.DataBind();
                if (list.Count == 0)
                    BookSearchEmpty.Visible = true;
                else
                    BookSearchEmpty.Visible = false;
            }

            LibaryManager.SaveSearchHistory(SearchKeywordTextBox.Text.Trim(), books.Distinct().Count(), CurrentUser);

        }
    }

    private Book SanitizeBookData(Book b)
    {
        b.Title = b.Title.Length > 1000 ? b.Title.Substring(0, 999): b.Title;
        b.Description = b.Description.Length > 3000 ? b.Description.Substring(0, 2999) : b.Description;
        b.Author = b.Author.Length > 2000 ? b.Author.Substring(0, 1999) : b.Author;
        b.ISBN10 = b.ISBN10.Length > 20 ? b.ISBN10.Substring(0, 19): b.ISBN10;
        b.ISBN13 = b.ISBN13.Length > 20 ? b.ISBN13.Substring(0, 19): b.ISBN13;
        b.PublishDate = b.PublishDate.Length > 50 ? b.PublishDate.Substring(0, 49) : b.PublishDate;
        b.Publisher = b.Publisher.Length > 250 ? b.Publisher.Substring(0, 249):b.Publisher;
        b.Categories = b.Categories.Length > 500 ? b.Categories.Substring(0, 499) : b.Categories;
        b.Identifiers = b.Identifiers.Length > 2000 ? b.Identifiers.Substring(0, 1999) : b.Identifiers;

        return b;
    }


    protected void ClearSearchButton_Click(object sender, EventArgs e)
    {
        SearchKeywordTextBox.Text = string.Empty;
        BookSearchEmpty.Visible = false;
    }

    protected void SearchResultRepeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            //Reference the Repeater Item.
            RepeaterItem item = e.Item;
            Literal AuthorLt = (item.FindControl("AuthorLt") as Literal);
            if (!string.IsNullOrEmpty(AuthorLt.Text))
                AuthorLt.Text = "Written by " + AuthorLt.Text;
        }
    }
}
