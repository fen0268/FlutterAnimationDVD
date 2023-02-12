int vectorBranchX(int num) {
  if (num == 0 || num == 3) {
    return 1000;
  } else {
    return -1000;
  }
}

int vectorBranchY(int num) {
  if (num == 0 || num == 1) {
    return -1000;
  } else {
    return 1000;
  }
}
