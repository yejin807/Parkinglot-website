package com.example.parking.exception;

import javax.validation.GroupSequence;
import javax.validation.groups.Default;

import com.example.parking.exception.ValidationGroups.NotEmptyGroup;
import com.example.parking.exception.ValidationGroups.PatternCheckGroup;

@GroupSequence({ Default.class, NotEmptyGroup.class, PatternCheckGroup.class })
public interface ValidationSequence {
}
