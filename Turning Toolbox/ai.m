function AnchoringIndex = ai(AbsoluteAngleSD,RelativeAngleSD)

AnchoringIndex = (RelativeAngleSD-AbsoluteAngleSD)/(RelativeAngleSD+AbsoluteAngleSD);
