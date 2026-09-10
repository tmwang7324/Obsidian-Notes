---
title: "Named Entity Recognition"
source: "https://www.geeksforgeeks.org/nlp/named-entity-recognition/"
author:
  - "[[GeeksforGeeks]]"
published: 2021-05-27
created: 2026-07-17
description: "Your All-in-One Learning Portal: GeeksforGeeks is a comprehensive educational platform that empowers learners across domains-spanning computer science and programming, school education, upskilling, commerce, software tools, competitive exams, and more."
tags:
  - "clippings"
---
Named Entity Recognition (NER) in [NLP](https://www.geeksforgeeks.org/nlp/introduction-to-natural-language-processing-nlp/) focuses on identifying and categorizing important information known as entities in text. These entities can be names of people, places, organizations, dates, etc. It helps in transforming unstructured text into structured information which helps in tasks like text summarization, knowledge graph creation and question answering.

![NER](https://media.geeksforgeeks.org/wp-content/uploads/20251216102233196838/NER.webp)

Working of NER

****Examples of Common Entity Types:****

- ****Person Names****: Albert Einstein
- ****Organizations****: GeeksforGeeks
- ****Locations****: Paris
- ****Dates and Times****: 5th May 2025
- ****Quantities and Percentages****: 50%, $100

It helps in handling ambiguity by analyzing surrounding words, structure of sentence and the overall context to make the correct classification. It means context can change based on entity’s meaning.

****Example:l****

- Amazon is expanding rapidly (Organization)
- The Amazon is the largest rainforest (Location)

## Working of Named Entity Recognition (NER)

Various steps involves in NER and are as follows:

1. ****Analyzing the Text****: It processes entire text to locate words or phrases that could represent entities.
2. ****Finding Sentence Boundaries****: It identifies starting and ending of sentences using punctuation and capitalization which helps in maintaining meaning and context of entities.
3. ****Tokenizing and Part-of-Speech Tagging****: Text is broken into tokens (words) and each token is tagged with its grammatical role which provides important clues for identifying entities.
4. ****Entity Detection and Classification****: Tokens or groups of tokens that match patterns of known entities are recognized and classified into predefined categories like Person, Organization, Location etc.
5. ****Model Training and Refinement****: Machine learning models are trained using labeled datasets and they improve over time by learning patterns and relationships between words.
6. ****Adapting to New Contexts****: A well-trained model can generalize to different languages, styles and unseen types of entities by learning from context.

## Methods of Named Entity Recognition

There are different methods present in NER which are:

### 1\. Lexicon Based Method

This method uses a dictionary of known entity names. This process involves checking if any of these words are present in a given text. However, this approach isn't commonly used because it requires constant updating and careful maintenance of the dictionary to stay accurate and effective.

### 2\. Rule Based Method

It uses a set of predefined rules which helps in extraction of information. These rules are based on patterns and context. Pattern-based rules focus on the structure and form of words helps in looking at their morphological patterns. On the other hand context-based rules focus on the surrounding words or the context in which a word appears within the text document.

### 3\. Machine Learning-Based Method

There are two main types of category in this:

- ****Multi-Class Classification****: Trains a classifier to assign each entity to predefined categories using labeled data.
- ****Conditional Random Field (CRF)****: It is implemented by both NLP Speech Tagger and [NLTK.](https://www.geeksforgeeks.org/python/nltk-nlp/) It is a probabilistic model that understands the sequence and context of words which helps in making entity prediction more accurate.

### 4\. Deep Learning Based Method

- ****Word Embeddings:**** Represent words as dense vectors that capture semantic meaning.
- ****Neural Networks:**** Models like [BiLSTM](https://www.geeksforgeeks.org/nlp/bidirectional-lstm-in-nlp/), [CNN](https://www.geeksforgeeks.org/deep-learning/convolutional-neural-network-cnn-in-machine-learning/) and [Transformers](https://www.geeksforgeeks.org/machine-learning/getting-started-with-transformers/) learn contextual patterns automatically.
- ****High Accuracy:**** Performs well on large and diverse datasets.

## Implementation

### Step 1: Installing Libraries

Firts we need to install necessary libraries. You can run the following commands in command prompt to install them.

> !pip install spacy  
> !pip install nltk

### Step 2: Importing and Loading data

We will be using [Pandas](https://www.geeksforgeeks.org/pandas/pandas-functions-in-python/) and [Spacy](https://www.geeksforgeeks.org/nlp/tokenization-using-spacy-library/) libraries to implement this.

- ****nlp = spacy.load("en\_core\_web\_sm")****: Loads the pre-trained "en\_core\_web\_sm" SpaCy model and stores it in the variable nlp for text processing tasks.

### Step 3: Applying NER to a Sample Text

We have created some random content to implement this you can use any text based on your choice.

- ****doc = nlp(content)****: Processes text stored in content using the nlp model and stores resulting document object in the variable doc for further analysis.
- ****for ent in doc.ents****: Iterates through the named entities (doc.ents) identified in the processed document and performs actions for each entity.

****Output:****

![ner1](https://media.geeksforgeeks.org/wp-content/uploads/20250427011500228140/ner1.webp)

Resulting document

It displays the names of the entities, their start and end positions in the text and their predicted labels.

### Step 4: Visualizing Entities

We will highlight the text with their categories using visualizing technique for better understanding.

- ****displacy.render(doc, style="ent")****: Visualizing named entities in the processed doc object by highlighting them in the text with their respective categories such as person, organization, location etc.

****Output:****

![ner2](https://media.geeksforgeeks.org/wp-content/uploads/20250427011719412913/ner2.webp)

Highlighted text with their categories

### Step 5: Creating a DataFrame for Entities

- ****entities = \[(ent.text, ent.label\_, ent.lemma\_) for ent in doc.ents****\]: Creating a list of tuples where each tuple contains the text, label (type) and lemma (base form) of each named entity found in the processed doc object.

****Output:****

![ner3](https://media.geeksforgeeks.org/wp-content/uploads/20250427011842562418/ner3.webp)

Text after categorization

Here dataframe provides a structured representation of the named entities, their types and lemmatized forms. NER helps organize unstructured text into structured information making it a useful for a wide range of NLP applications.

> You can download the complete code from [here](https://media.geeksforgeeks.org/wp-content/uploads/20260703113927501454/Named-Entity-Recognition.ipynb).

3 Questions

Which of the following is NOT typically recognized as an entity in NER?

In the sentence “Amazon is expanding rapidly”, what does NER classify "Amazon" as?

Which method of NER uses probabilistic models like Conditional Random Fields (CRF)?

![success](https://media.geeksforgeeks.org/auth-dashboard-uploads/sucess-img.png)

Quiz Completed Successfully

Your Score:0/3

Accuracy:0%