///*
// * All content copyright Terracotta, Inc., unless otherwise indicated. All rights reserved.
// *
// * Licensed under the Apache License, Version 2.0 (the "License");
// * you may not use this file except in compliance with the License.
// * You may obtain a copy of the License at
// *
// *      http://www.apache.org/licenses/LICENSE-2.0
// *
// * Unless required by applicable law or agreed to in writing, software
// * distributed under the License is distributed on an "AS IS" BASIS,
// * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// * See the License for the specific language governing permissions and
// * limitations under the License.
// */
//package org.quartz.integrations.tests;
//
//import org.junit.Test;
//import org.quartz.*;
//import org.quartz.utils.Key;
//
//import static org.hamcrest.CoreMatchers.is;
//import static org.hamcrest.Matchers.not;
//import static org.junit.Assert.assertThat;
//import static org.quartz.CronScheduleBuilder.cronSchedule;
//import static org.quartz.JobBuilder.newJob;
//import static org.quartz.TriggerBuilder.newTrigger;
//
///**
// * Created by zemian on 10/25/16.
// */
//public class QuartzMemoryPauseAndResumeTest extends QuartzMemoryTestSupport {
//
////    @Test
////    public void testPauseAndResumeTriggers() throws Exception {
////        JobDetail jobDetail = newJob(HelloJob.class)
////                .withIdentity("test")
////                .build();
////
////        CronTrigger trigger = newTrigger()
////                .withIdentity("test"/* , "abc"  */)
////                .withSchedule(cronSchedule("* * * * * ?"))
////                .build();
////
////        scheduler.scheduleJob(jobDetail, trigger);
////
////        Trigger.TriggerState state = scheduler.getTriggerState(Key.key("test"/* , "abc"  */));
////        assertThat(state, is(Trigger.TriggerState.NORMAL));
////        assertThat(state, not(Trigger.TriggerState.PAUSED));
////
//////        scheduler.pauseTriggers(GroupMatcher.triggerGroupEquals("abc"));
////        state = scheduler.getTriggerState(Key.key("test"/* , "abc"  */));
////        assertThat(state, is(Trigger.TriggerState.PAUSED));
////        assertThat(state, not(Trigger.TriggerState.NORMAL));
////
////        scheduler.resumeTriggers(GroupMatcher.triggerGroupEquals("abc"));
////        state = scheduler.getTriggerState(Key.key("test"/* , "abc"  */));
////        assertThat(state, is(Trigger.TriggerState.NORMAL));
////        assertThat(state, not(Trigger.TriggerState.PAUSED));
////    }
////
////    @Test
////    public void testResumeTriggersBeforeAddJob() throws Exception {
//////        scheduler.pauseTriggers(GroupMatcher.triggerGroupEquals("abc"));
////        scheduler.resumeTriggers(GroupMatcher.triggerGroupEquals("abc"));
////
////        JobDetail jobDetail = newJob(HelloJob.class)
////                .withIdentity("test")
////                .build();
////
////        CronTrigger trigger = newTrigger()
////                .withIdentity("test"/* , "abc"  */)
////                .withSchedule(cronSchedule("* * * * * ?"))
////                .build();
////
////        scheduler.scheduleJob(jobDetail, trigger);
////
////        Trigger.TriggerState state = scheduler.getTriggerState(Key.key("test"/* , "abc"  */));
////        assertThat(state, is(Trigger.TriggerState.NORMAL));
////        assertThat(state, not(Trigger.TriggerState.PAUSED));
////
//////        scheduler.pauseTriggers(GroupMatcher.triggerGroupEquals("abc"));
////        state = scheduler.getTriggerState(Key.key("test"/* , "abc"  */));
////        assertThat(state, is(Trigger.TriggerState.PAUSED));
////        assertThat(state, not(Trigger.TriggerState.NORMAL));
////
////        scheduler.resumeTriggers(GroupMatcher.triggerGroupEquals("abc"));
////        state = scheduler.getTriggerState(Key.key("test"/* , "abc"  */));
////        assertThat(state, is(Trigger.TriggerState.NORMAL));
////        assertThat(state, not(Trigger.TriggerState.PAUSED));
////    }
//
//    @Test
//    public void testPauseAndResumeJobs() throws Exception {
//        JobDetail jobDetail = newJob(HelloJob.class)
//                .withIdentity("test"/* , "abc"  */)
//                .build();
//
//        CronTrigger trigger = newTrigger()
//                .withIdentity("test"/* , "abc"  */)
//                .withSchedule(cronSchedule("* * * * * ?"))
//                .build();
//
//        scheduler.scheduleJob(jobDetail, trigger);
//
//        Trigger.TriggerState state = scheduler.getTriggerState(Key.key("test"/*/* , "abc"  */));
//        assertThat(state, is(Trigger.TriggerState.NORMAL));
//        assertThat(state, not(Trigger.TriggerState.PAUSED));
//
//        scheduler.pauseJobs("abc");
//        state = scheduler.getTriggerState(Key.key("test"/*/* , "abc"  */));
//        assertThat(state, is(Trigger.TriggerState.PAUSED));
//        assertThat(state, not(Trigger.TriggerState.NORMAL));
//
//        scheduler.resumeJobs("abc");
//        state = scheduler.getTriggerState(Key.key("test"/*/* , "abc"  */));
//        assertThat(state, is(Trigger.TriggerState.NORMAL));
//        assertThat(state, not(Trigger.TriggerState.PAUSED));
//    }
//
//
//    @Test
//    public void testResumeJobsBeforeAddJobs() throws Exception {
//        scheduler.pauseJobs("abc");
//        scheduler.resumeJobs("abc");
//
//        JobDetail jobDetail = newJob(HelloJob.class)
//                .withIdentity("test"/* , "abc"  */)
//                .build();
//
//        CronTrigger trigger = newTrigger()
//                .withIdentity("test"/* , "abc"  */)
//                .withSchedule(cronSchedule("* * * * * ?"))
//                .build();
//
//        scheduler.scheduleJob(jobDetail, trigger);
//
//        Trigger.TriggerState state = scheduler.getTriggerState(Key.key("test"/*/* , "abc"  */));
//        assertThat(state, is(Trigger.TriggerState.NORMAL));
//        assertThat(state, not(Trigger.TriggerState.PAUSED));
//
//        scheduler.pauseJobs("abc");
//        state = scheduler.getTriggerState(Key.key("test"/*/* , "abc"  */));
//        assertThat(state, is(Trigger.TriggerState.PAUSED));
//        assertThat(state, not(Trigger.TriggerState.NORMAL));
//
//        scheduler.resumeJobs("abc");
//        state = scheduler.getTriggerState(Key.key("test"/*/* , "abc"  */));
//        assertThat(state, is(Trigger.TriggerState.NORMAL));
//        assertThat(state, not(Trigger.TriggerState.PAUSED));
//    }
//}
