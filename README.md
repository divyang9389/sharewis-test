# Exercise for ShareWis's Candidates (Ruby on Rails Engineers)

This repository [Github Link](https://github.com/viphat/sharewis-test) is a basic application written in Rails 5.2 and have only some models as screenshot below:

![Screenshot](https://i.gyazo.com/e70cbf2d80a1d81b3c2e0892b8262646.png)

Currently, there are only two API endpoints: GET `/courses/index` and `/categories/:id/`, your jobs are cleaning the ugly/messy code of `courses#index` without changing its business logics and also apply these changes to `categories#show`. However, as we don't have any tests, beforehand, add tests to make sure the refactored code doesn't change the behaviors.

**This exercise will focus on**:

- Writing well-designed tests (We expect that every changes you made must be covered by tests).
- Refactoring with solid object-oriented design skills (SOLID, DRY, ...)
  - Clean, Easy to read, easy to change code.
- Performance Optimization (Such as JSON Rendering, SQL Indexing, and some other techniques that can be applied.)
- Use Git, and follow **commit early, commit often but meaningful** so we can check your code commits and see how the codebase is changed and evolved.

**Requirements**:

- When a course is created, it's in draft status (`published: false`), in order to be able to publish the course, it requires to have at least one course locale records, if not, refuse to change the published status. (By the way, these models are missing some validations, please add them).
- Add a search by keyword feature to `Courses#index` and `Categories#show`, that use `params[:q]` and filter courses that have course's id, course title, category name, instructor name, tag name that include the keyword - For Courses' ID, it should match exactly the keyword provided, for example, if the keyword is 101, it should return the course with id 101, if exists, not 1011, 1010, etc.)
