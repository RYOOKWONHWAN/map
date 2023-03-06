package controller;

public class adre {
	public static void main(String[] args) {

		GetAddress ga= new GetAddress();
		for(int i = 0; i < ga.GetAdr().size(); i++) {
			System.out.println(ga.GetAdr().get(i));
		}
		
		
		

	}
}
