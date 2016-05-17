int main(){
  int[] speeds={18,18,18,18,18,18};
  int[] kick_speeds={0,0,0,0,0,0};

  int[] home = {1500,1500,1550,1650,1700,1450};

	//STEPS
  int[] r_step_1={1500,1500,1400,1650,1700,1700};
  int[] r_step_2={1500,1500,1400,2000,1500,1450};

  int[] l_step_1={1500,1500,1300,1650,1700,1600};
  int[] l_step_2={1300,1700,1550,1650,1700,1600};

  Komms komm = new Komms();
  komm.startKomms();
  komm.setSpeeds(speeds);
  komm.setTargets(home);
  Posix.usleep(1000000);

  for(int i=0;i<=2;i++){
    komm.setTargets(home);
    Posix.usleep(1000*1000);
    komm.setTargets(l_step_1);
    Posix.usleep(1000*1000);
    komm.setTargets(l_step_2);
    Posix.usleep(1000*1000);

  }

  komm.setTargets(home);
  return 0;
}
