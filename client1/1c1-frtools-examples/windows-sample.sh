#!/bin/bash

  docr set pause off

  docr start "This is a Sample"

  docr note  "The RDIR Command"
  docr space
  docr step  "Step 1"
  docr step  "Step 2"
  docr space
  docr code  "rdir"
  docr note  "The List Commits Commands"
  docr line
  docr code  "gitr list remote commits -y 3"
  docr code  "gitr list local commits -y 3"
  docr end


