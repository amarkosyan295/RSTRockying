using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Rockying.Models
{

    //public class VisitChatBoard
    //{
    //    public Guid ID { get; set; }
    //    public DateTime CreateDate { get; set; }
    //    public List<VisitChatMessage> MessageList { get; set; }

    //    public VisitChatBoard()
    //    {
    //        ID = Guid.NewGuid();
    //        CreateDate = DateTime.Now;
    //        MessageList = new List<VisitChatMessage>();
    //    }
    //}

    //public class VisitChatMessage
    //{
    //    public int ID { get; set; }
    //    public long SenderID { get; set; }
    //    public string Message { get; set; }
    //    public string Name { get; set; }
    //    public string Image { get; set; }
    //    public DateTime SentDate { get; set; }
    //    public VisitChatMessageType MessageType { get; set; }

    //    public VisitChatMessage(string message, long senderId, string name)
    //    {
    //        ID = 0;
    //        SenderID = senderId;
    //        Message = message;
    //        Name = name;
    //        Image = string.Empty;
    //        SentDate = DateTime.Now;
    //        MessageType = VisitChatMessageType.Message;
    //    }
    //}

    //public enum VisitChatMessageType
    //{
    //    Message = 1
    //}

    //public class VisitChatManager
    //{
    //    VisitChatBoard board = null;
    //    public VisitChatManager(VisitChatBoard b)
    //    {
    //        board = b;
    //    }

    //    public VisitChatBoard Board { get { return board; } }

    //    public VisitChatBoard PushSentMessage(long sender, string message, string name, string image)
    //    {
    //        board.MessageList.Add(new VisitChatMessage(message, sender, name) { ID = board.MessageList.Count() + 1, Image = image });

    //        return board;
    //    }

    //    public VisitChatMessage GetLastMessage()
    //    {
    //        if (board.MessageList.Count > 0)
    //        {
    //            return board.MessageList.Last();
    //        }
    //        else { return null; }
    //    }

    //    public List<VisitChatMessage> GetMessageUntil(int messageId)
    //    {
    //        List<VisitChatMessage> list = new List<VisitChatMessage>();
    //        for (int i = board.MessageList.Count() - 1; i >= 0; i--)
    //        {
    //            if (board.MessageList[i].ID > messageId)
    //            {
    //                list.Insert(0, board.MessageList[i]);
    //            }
    //            else { break; }
    //        }
    //        return list;
    //    }

    //}
}