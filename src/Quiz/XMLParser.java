//package Quiz;
//import java.util.ArrayList;
//
////import java.io.File;
////import java.io.IOException;
////import java.util.List;
////import javax.xml.parsers.DocumentBuilder;
////import javax.xml.parsers.DocumentBuilderFactory;
////import javax.xml.parsers.ParserConfigurationException;
////import org.w3c.dom.Document;
////import org.w3c.dom.Element;
////import org.w3c.dom.Node;
////import org.w3c.dom.NodeList;
//import org.xml.sax.SAXException;
//import org.xml.sax.helpers.DefaultHandler;
//import org.xml.sax.Attributes;
//
//public class XMLParser extends DefaultHandler {
//
//	private Quiz quiz; // = new Quiz(tmpValue, tmpValue, tmpValue, null);
//	private ArrayList < Question > questions = null;
//	private Question tmpQuestion;
//	private String userID;
//	String tmpValue = null;
//
//	@Override
//	public void startElement(String uri, String localName, String qName, Attributes attributes)
//	throws SAXException {
//
//		switch (qName) {
//			case "quiz":
//				String quizType = "";
//				if(attributes.getValue("random").equals("true")) quizType += "R";
//				if(attributes.getValue("one-page").equals("false")) quizType += "M";
//				if(attributes.getValue("immediate-correction").equals("true")) quizType += "I";
//				if(attributes.getValue("practice-mode").equals("true")) quizType += "P";;
//				break;
//
//			case "question":
//				String time = Long.toString(System.currentTimeMillis());
//				tmpQuestion = new Question();
//				tmpQuestion.problemID = userID + time;
//				tmpQuestion.problemType = attributes.getValue("type");
//				break;
//
//
//		}
//	}
//
//	@Override
//	public void endElement(String uri, String localName, String qName) throws SAXException {
//		switch (qName) {
//			case "title":
//				{
//					// The end tag of quiz (the whole file)
//					quiz.quizName = tmpValue;
//					break;
//				}
//			case "description":
//				{
//					quiz.description = tmpValue;
//					break;
//				}
//			case "question":
//				{
//					questions.add(tmpQuestion);
//					break;
//				}
//			case "image-location":
//				{
//					tmpQuestion.picutreUrl = tmpValue;
//					break;
//				}
//		}
//	}
//
//
//	@Override
//	public void characters(char[] ac, int i, int j) throws SAXException {
//		tmpValue = new String(ac, i, j);
//	}
//
//
//}
