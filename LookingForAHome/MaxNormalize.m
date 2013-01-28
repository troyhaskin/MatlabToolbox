function NormedArray = MaxNormalize(Array)
    NormedArray = Array / max(max(Array));
end