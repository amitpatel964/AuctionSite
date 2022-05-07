package javaClasses;

/**
 * This class is used to help organize the information for a question.
 * 
 * @author Amit
 *
 */

public class Question {
	
	private int questionID;
	private String usernameAsker;
	private String questionTitle;
	private String questionBodyContent;
	private String usernameResponder;
	private String answerBodyContent;
	private int questionAnswered;
	
	public Question(int questionID, String usernameAsker, String questionTitle, String questionBodyContent,
			String usernameResponder, String answerBodyContent, int questionAnswered) {
		this.questionID = questionID;
		this.usernameAsker = usernameAsker;
		this.questionTitle = questionTitle;
		this.questionBodyContent = questionBodyContent;
		this.usernameResponder = usernameResponder;
		this.answerBodyContent = answerBodyContent;
		this.questionAnswered = questionAnswered;
	}

	public int getQuestionID() {
		return questionID;
	}

	public String getUsernameAsker() {
		return usernameAsker;
	}

	public String getQuestionTitle() {
		return questionTitle;
	}

	public String getQuestionBodyContent() {
		return questionBodyContent;
	}

	public String getUsernameResponder() {
		return usernameResponder;
	}

	public String getAnswerBodyContent() {
		return answerBodyContent;
	}

	public int getQuestionAnswered() {
		return questionAnswered;
	}
}
