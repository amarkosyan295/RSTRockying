using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Rockying.Models
{
    public class LibaryManager
    {
        public static Book GetBook(int id)
        {
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
            {
                Book b = dc.Books.FirstOrDefault(t => t.ID == id);
                return b;
            }
        }
        public static void AddBookToLibrary(Book b,Member m, ReadStatusType rs)
        {
            try
            {
                using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
                {
                    MemberBook mb = dc.MemberBooks.FirstOrDefault(t => t.MemberID == m.ID && t.BookID == b.ID);
                    if(mb == null)
                    {
                        mb = new MemberBook()
                        {
                            BookID = b.ID,
                            MemberID = m.ID,
                            Review = string.Empty,
                            ReadStatus = (byte)rs
                        };
                        dc.MemberBooks.InsertOnSubmit(mb);
                    }
                    else
                    {
                        mb.ReadStatus = (byte)rs;
                    }
                    dc.SubmitChanges();
                }
            }
            catch
            {
                throw;
            }
        }
    }
}